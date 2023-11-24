//
//  LoginPage.swift
//  Breathe Easy
//
//  Created by Nikhil Kumar on 11/23/23.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct LoginPage: View {
    
    // Loading Indicator
    @State var isLoading: Bool = false
    
    @AppStorage("log_Status") var log_Status = false
    @AppStorage("name") var name = ""
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing: 20){
                Color(UIColor.darkGray).ignoresSafeArea()
                
                // Sign In Button
                
                Button{
                    handleLogin()
                } label: {
                    HStack(spacing: 14){
                        Image("colorG")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 28, height: 28)
                            .cornerRadius(14)
                        Text("Sign in with Google")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.9)
                }
                .background(Color.white)
                .cornerRadius(30)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.black))
                
            }
            .overlay(
                ZStack{
                    
                    if isLoading{
                        Color.black.opacity(0.25).ignoresSafeArea()
                        
                        ProgressView()
                            .font(.title2)
                            .frame(width: 60, height: 60)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
            )
        }
        .background(Color(UIColor.darkGray))
    }
    
    // handle login
    func handleLogin(){
        
        // google sign in
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        isLoading = true
        
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) {[] result, error in
            
            if let error = error{
                isLoading = false
                print(error.localizedDescription)
                return
            }
            
//            guard error == nil else {
//                print(error.localizedDescription)
//                return
//            }
            
            guard 
                let user = result?.user,
                let idToken = user.idToken?.tokenString
            else {
                isLoading = false
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            // Firebase Auth
            Auth.auth().signIn(with: credential){ result2, error in
                isLoading = false
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                
                // displaying user name
                guard let user2 = result2?.user else{
                    return
                }
                
                print(user2.displayName ?? "Success!")
                name = user2.displayName ?? "Name Undefined"
                
                // updating user as logged in
                withAnimation{
                    log_Status = true
                }
            }
        }
        
    }
    
}

#Preview {
    LoginPage()
}

// extending view to get screen bounds
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    
    // retrieving root view controller
    func getRootViewController()->UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        
        return root
    }
}
