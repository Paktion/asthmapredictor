import Foundation
import SwiftUI
import Charts
import Firebase
import GoogleSignIn
struct Pf:Codable{
    let value:Float
}
enum GHError: Error{
    case invalidURL
    case invalidResponse
    case invalidData
}

struct MyVars {
    var DataPoints: [Double]
}

struct Home: View{
    func getPf(url: String) async throws -> Pf{
        let endpoint = url
        
        guard let url=URL(string:endpoint) else{
            throw GHError.invalidURL
        }
        
        let (data,response) = try await URLSession.shared.data(from:url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {throw GHError.invalidResponse}
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Pf.self, from:data)
        }catch {
            throw GHError.invalidData
        }
    }
    
    @State private var user: Pf?
    
    var body: some View {
        ZStack{
            Color(UIColor.darkGray).ignoresSafeArea()
            VStack(alignment: .center){
                if user?.value ?? 0 >= 0 && user?.value ?? 0 < 0.50{
                    Text("Peak Flow")
                        .font(.system(size: 55, weight: .bold)).multilineTextAlignment(.center).foregroundColor(Color(UIColor.systemGray5))
                    Image("redt").resizable().frame(width: 300, height: 300)
                    Text(String(format: "%.0f%%",(user?.value ?? 0)*100))
                        .font(.system(size: 55, weight: .bold)).foregroundColor(Color(UIColor.systemGray5))
                    Text("of predicted maximum peak flow value")
                        .font(.system(size: 15, weight: .bold)).foregroundColor(Color(UIColor.systemGray5))
                        .padding()
                    Text("You may be at severe risk of an asthma attack")
                        .font(.system(size: 15, weight: .bold)).foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                else if user?.value ?? 0 >= 0.50 && user?.value ?? 0 < 0.60{
                    Text("Peak Flow")
                        .font(.system(size: 55, weight: .bold)).multilineTextAlignment(.center).foregroundColor(Color(UIColor.systemGray5))
                    Image("oranget").resizable().frame(width: 300, height: 300)
                    Text(String(format: "%.0f%%",(user?.value ?? 0)*100))
                        .font(.system(size: 55, weight: .bold)).foregroundColor(Color(UIColor.systemGray5))
                    Text("of predicted maximum peak flow value")
                        .font(.system(size: 15, weight: .bold)).foregroundColor(Color(UIColor.systemGray5))
                        .padding()
                    Text("You may be at moderate-severe risk of an asthma attack")
                        .font(.system(size: 15, weight: .bold)).foregroundColor(.orange)
                        .multilineTextAlignment(.center)
                }
                else if user?.value ?? 0 >= 0.60 && user?.value ?? 0 < 0.70{
                    Text("Peak Flow")
                        .font(.system(size: 55, weight: .bold)).multilineTextAlignment(.center).foregroundColor(Color(UIColor.systemGray5))
                    Image("yellowt").resizable().frame(width: 300, height: 300)
                    Text(String(format: "%.0f%%",(user?.value ?? 0)*100))
                        .font(.system(size: 55, weight: .bold)).foregroundColor(Color(UIColor.systemGray5))
                    Text("of predicted maximum peak flow value")
                        .font(.system(size: 15, weight: .bold)).foregroundColor(Color(UIColor.systemGray5))
                        .padding()
                    Text("You may be at moderate risk of an asthma attack")
                        .font(.system(size: 15, weight: .bold)).foregroundColor(.yellow)
                        .multilineTextAlignment(.center)
                }
                else if user?.value ?? 0 >= 0.70 && user?.value ?? 0 < 0.80{
                    Text("Peak Flow")
                        .font(.system(size: 55, weight: .bold)).multilineTextAlignment(.center).foregroundColor(Color(UIColor.systemGray5))
                    Image("lightgreent").resizable().frame(width: 300, height: 300)
                    Text(String(format: "%.0f%%",(user?.value ?? 0)*100))
                        .font(.system(size: 55, weight: .bold)).foregroundColor(Color(UIColor.systemGray5))
                    Text("of predicted maximum peak flow value")
                        .font(.system(size: 15, weight: .bold)).foregroundColor(Color(UIColor.systemGray5))
                        .padding()
                    Text("You may be at slight risk of an asthma attack")
                        .font(.system(size: 15, weight: .bold)).foregroundColor(Color(UIColor.systemGreen))
                        .multilineTextAlignment(.center)
                }else if user?.value ?? 0 >= 0.80 {
                    Text("Peak Flow")
                        .font(.system(size: 55, weight: .bold)).multilineTextAlignment(.center).foregroundColor(Color(UIColor.systemGray5))
                    Image("greent").resizable().frame(width: 300, height: 300)
                    Text(String(format: "%.0f%%",(user?.value ?? 0)*100))
                        .font(.system(size: 55, weight: .bold)).foregroundColor(Color(UIColor.systemGray5))
                    Text("of predicted maximum peak flow value")
                        .font(.system(size: 15, weight: .bold)).foregroundColor(Color(UIColor.systemGray5))
                        .padding()
                    Text("You can breathe easy!")
                        .font(.system(size: 15, weight: .bold)).foregroundColor(.green)
                        .multilineTextAlignment(.center)
                }
            }
        }
        
        .task{
            do{
                user = try await getPf(url: "http://127.0.0.1:5000/22.0/15.0/15.0/9.0/1040.0/98.0/1.51/0.0/2.0/292.72/20.39/11.54/2.27/11.64/16.40/0.39/83.0")
                try await Task.sleep(nanoseconds: 3_000_000_000)
            } catch GHError.invalidURL{
                print("invalid URL")
            }catch GHError.invalidResponse{
                print("invalid response")
            }catch GHError.invalidData{
                print("invalid data")
            }catch{
                print("Error")
            }
            
            do{
                user = try await getPf(url: "http://127.0.0.1:5000/22.0/15.0/15.0/12.0/1040.0/98.0/2.51/0.0/2.0/283.72/20.39/21.99/2.27/11.64/16.40/0.39/83.0")
                try await Task.sleep(nanoseconds: 2_500_000_000)
            } catch GHError.invalidURL{
                print("invalid URL")
            }catch GHError.invalidResponse{
                print("invalid response")
            }catch GHError.invalidData{
                print("invalid data")
            }catch{
                print("Error")
            }
            
            do{
                user = try await getPf(url: "http://127.0.0.1:5000/22.0/15.0/15.0/14.0/1040.0/98.0/2.51/0.0/2.0/283.72/20.39/21.99/2.27/11.64/16.40/0.39/83.0")
                try await Task.sleep(nanoseconds: 2_500_000_000)
            } catch GHError.invalidURL{
                print("invalid URL")
            }catch GHError.invalidResponse{
                print("invalid response")
            }catch GHError.invalidData{
                print("invalid data")
            }catch{
                print("Error")
            }
            
            
            do{
                user = try await getPf(url: "http://127.0.0.1:5000/22.0/15.0/15.0/11.0/1040.0/98.0/2.51/0.0/2.0/283.72/20.39/21.99/2.27/11.64/16.40/0.39/83.0")
                try await Task.sleep(nanoseconds: 2_500_000_000)
            } catch GHError.invalidURL{
                print("invalid URL")
            }catch GHError.invalidResponse{
                print("invalid response")
            }catch GHError.invalidData{
                print("invalid data")
            }catch{
                print("Error")
            }
            
            do{
                user = try await getPf(url: "http://127.0.0.1:5000/22.0/15.0/15.0/15.0/1040.0/98.0/2.51/0.0/2.0/283.72/20.39/21.99/2.27/11.64/16.40/0.39/83.0")
                try await Task.sleep(nanoseconds: 2_500_000_000)
            } catch GHError.invalidURL{
                print("invalid URL")
            }catch GHError.invalidResponse{
                print("invalid response")
            }catch GHError.invalidData{
                print("invalid data")
            }catch{
                print("Error")
            }
            
            do{
                user = try await getPf(url: "http://127.0.0.1:5000/22.0/15.0/15.0/17.0/1040.0/98.0/2.51/0.0/2.0/283.72/20.39/21.99/2.27/11.64/16.40/0.39/83.0")
                try await Task.sleep(nanoseconds: 2_500_000_000)
            } catch GHError.invalidURL{
                print("invalid URL")
            }catch GHError.invalidResponse{
                print("invalid response")
            }catch GHError.invalidData{
                print("invalid data")
            }catch{
                print("Error")
            }
            
            do{
                user = try await getPf(url: "http://127.0.0.1:5000/22.0/15.0/15.0/22.0/1040.0/98.0/2.51/0.0/2.0/283.72/20.39/21.99/2.27/11.64/16.40/0.39/83.0")
                try await Task.sleep(nanoseconds: 2_500_000_000)
            } catch GHError.invalidURL{
                print("invalid URL")
            }catch GHError.invalidResponse{
                print("invalid response")
            }catch GHError.invalidData{
                print("invalid data")
            }catch{
                print("Error")
            }
            
        }
        
    }
}

struct ViewAbout: View{
    var body: some View{
        ZStack(alignment: .center){
                Color(UIColor.darkGray)
                    .ignoresSafeArea()
                ScrollView{
                    Text("""
Welcome to Breathe Easy, your trusted companion in the management of asthma. This documentation serves as an in-app guide to help you maximize the benefits of our application, designed to assist you in monitoring your peak flow and preventing asthma attacks.
                 
Breathe Easy boasts several key features that empower you in managing your asthma effectively. It provides real-time peak flow predictions powered by a machine learning regression model. The app leverages heart rate data from your Apple Watch and takes into account factors such as air quality and temperature to offer personalized insights.
                 
Breathe Easy is designed to deliver timely alerts and notifications, all seamlessly integrated with AWS for machine learning predictions.

To get started with Breathe Easy, simply sign in using your existing account credentials. If you're a new user, you can effortlessly create an account to access all the app's features.

Once you're inside the app, you'll be greeted by a user-friendly home screen displaying your current peak flow prediction and other essential information. You can review your past predictions and health insights in the trends tab. Breathe Easy continuously monitors your heart rate through watchOS data, and additionally measures other relevant factors with Apple’s WeatherKit to provide real-time peak flow predictions. It offers immediate feedback and compares your current peak flow to your maximum predicted value. It will alert you if your peak flow drops significantly, potentially indicating an asthma attack.

You can easily customize your alert thresholds and notification preferences to suit your needs. The app will send timely alerts to your iOS device and Apple Watch, ensuring you're well-informed and can take necessary actions in the event your peak flow is at risk.

Breathe Easy is here to provide you with the tools you need to manage your asthma with confidence and peace of mind. Thank you for choosing Breathe Easy.
""")
                    .foregroundColor(Color(UIColor.white)).padding()
                    .multilineTextAlignment(.center)
                }
                .frame(width: .infinity, height: 660)
                .zIndex(1)
            }
            .zIndex(2)
        }
    }

struct ContentView: View {
    @AppStorage("log_Status") var log_Status = false
    @AppStorage("name") var name = ""
    @State private var showAlertDel = false
    @State private var showAlertLogOut = false
    var body: some View{
        if log_Status{
            TabView{
                // HOME VIEW
                Home()
                    .tabItem(){
                        Image(systemName: "lungs.fill")
                        Text("Home")
                    }.toolbarBackground(Color.white, for: .tabBar)
                
                // ABOUT VIEW
                ViewAbout()
                    .tabItem(){
                        Image(systemName: "info.circle")
                        Text("About")
                    }.toolbarBackground(Color.white, for: .tabBar)
                
                // PROFILE VIEW
                NavigationView {
                    ZStack{
                        Color(UIColor.systemGray5).ignoresSafeArea()
                        VStack {
                            
                            // log out button
                            Button{
                                showAlertLogOut = true
                            } label: {
                                VStack{
                                    Divider()
                                    HStack{
                                        Text("Log Out")
                                            .font(.body).foregroundStyle(Color(UIColor.black))
                                        Spacer()
                                    }
                                    .padding(EdgeInsets(top: 10, leading: 21, bottom: 10, trailing: 21))
                                    Divider()
                                }
                            }
                            .alert("Are you sure?", isPresented: $showAlertLogOut, actions: {
                                Button("Log Out", role: .destructive) {
                                    GIDSignIn.sharedInstance.signOut()
                                    try? Auth.auth().signOut()
                                    
                                    withAnimation{
                                        log_Status = false
                                    }
                                }
                            })
                            
                            // delete account button
                            Button{
                                showAlertDel = true
                            } label: {
                                VStack{
                                    HStack{
                                        Text("Delete Account")
                                            .font(.body).foregroundStyle(Color.red)
                                        Spacer()
                                    }
                                    .padding(EdgeInsets(top: 10, leading: 21, bottom: 10, trailing: 21))
                                    Divider()
                                }
                            }
                            .alert("Are you sure?", isPresented: $showAlertDel, actions: {
                                Button("Delete", role: .destructive) {
                                    let user = Auth.auth().currentUser
                                    
                                    user?.delete { error in
                                        if let error = error {
                                            print(error.localizedDescription)
                                        } else {
                                            print("Deletion Success")
                                        }
                                    }
                                    
                                    GIDSignIn.sharedInstance.signOut()
                                    try? Auth.auth().signOut()
                                    
                                    withAnimation{
                                        log_Status = false
                                    }
                                }
                            }, message: {
                                Text("Deleting this account will delete all stored data")
                            })
                            Spacer()
                        }
                        .navigationBarTitle(Text(name))
                    }
                }.tabItem(){
                    Image(systemName: "person.fill")
                    Text("Profile")
                }.toolbarBackground(Color.white, for: .tabBar)
            }
        }else{
             LoginPage()
        }
        
    }
}

#Preview {
    ContentView()
}
