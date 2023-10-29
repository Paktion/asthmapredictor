//
//  ContentView.swift
//  Breathe Easy
//
//  Created by Amogh Kuppa on 10/28/23.
//
/*func apiCall() -> String{
    if let url = URL(string: "http://127.0.0.1:5000/22.0/2.54/0.77/4.84/1040.0/98.0/0.51/0.0/2.0/283.72/20.39/21.99/2.27/11.64/16.40/0.39/83.0") {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                return
            }
            
            if let data = data {
                if let stringData = String(data: data, encoding: .utf8) {
                    return "hi"
                }
            }
        }
    }
}*/

import Foundation
// Usage of the function
struct Pf:Codable{
    let value:Float
}
enum GHError: Error{
    case invalidURL
    case invalidResponse
    case invalidData
}

struct ViewA: View{
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
            if user?.value ?? 0 >= 0 && user?.value ?? 0 < 0.50{
                Color(UIColor.lightGray).ignoresSafeArea()
                Text("Peak Flow")
                    .font(.system(size: 35, weight: .bold)).multilineTextAlignment(.center).position(x: 197, y: 200)
                Image("lung50t1").resizable().frame(width: 300, height: 300)
                Text(String(format: "%.0f%%",(user?.value ?? 0)*100))
                    .font(.system(size: 35)).position(x:197,y:550)
            }
            else if user?.value ?? 0 >= 0.50 && user?.value ?? 0 < 0.60{
                Color(UIColor.lightGray).ignoresSafeArea()
                Text("Peak Flow")
                    .font(.system(size: 35, weight: .bold)).multilineTextAlignment(.center).position(x: 197, y: 200)
                Image("60tfixed").resizable().frame(width: 300, height: 300)
                Text(String(format: "%.0f%%",(user?.value ?? 0)*100))
                    .font(.system(size: 35)).position(x:197,y:550)
            }
            else if user?.value ?? 0 >= 0.60 && user?.value ?? 0 < 0.70{
                Color(UIColor.lightGray).ignoresSafeArea()
                Text("Peak Flow")
                    .font(.system(size: 35, weight: .bold)).multilineTextAlignment(.center).position(x: 197, y: 200)
                Image("70tfixed").resizable().frame(width: 300, height: 300)
                Text(String(format: "%.0f%%",(user?.value ?? 0)*100))
                    .font(.system(size: 35)).position(x:197,y:550)
            }
            else if user?.value ?? 0 >= 0.70 && user?.value ?? 0 < 0.80{
                Color(UIColor.lightGray).ignoresSafeArea()
                Text("Peak Flow")
                    .font(.system(size: 35, weight: .bold)).multilineTextAlignment(.center).position(x: 197, y: 200)
                Image("80t").resizable().frame(width: 300, height: 300)
                Text(String(format: "%.0f%%",(user?.value ?? 0)*100))
                    .font(.system(size: 35)).position(x:197,y:550)
            }else if user?.value ?? 0 >= 0.80 {
                Color(UIColor.lightGray).ignoresSafeArea()
                Text("Peak Flow")
                    .font(.system(size: 35, weight: .bold)).multilineTextAlignment(.center).position(x: 197, y: 200)
                Image("80plust").resizable().frame(width: 300, height: 300)
                Text(String(format: "%.0f%%",(user?.value ?? 0)*100))
                    .font(.system(size: 35)).position(x:197,y:550)
            }
            
            
            
            
            
            //            VStack {
            //                Text("Peak Flow")
            //                    .font(.system(size: 24, weight: .bold)).multilineTextAlignment(.center).position(x: 197, y: 200)
            //                Image(systemName: "lungs")
            //                    .imageScale(.large).position(x: 197,y: 220)
            //                    .foregroundColor(.black)
            //                Text(String(format: "%.0f%%",(user?.value ?? 0)*100))
            //                    .font(.title2).position(x:197)
            //                    }
            
        }
        .task{
            do{
                user = try await getPf(url: "http://127.0.0.1:5000/22.0/15.0/15.0/10.0/1040.0/98.0/2.51/0.0/2.0/283.72/20.39/21.99/2.27/11.64/16.40/0.39/83.0")
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

struct ViewB: View{
    var body: some View{
        ZStack{
            Color.red
        }
    }
}

struct ViewC: View{
    var body: some View{
        ZStack{
            Color.blue
        }
    }
}

import SwiftUI

struct ContentView: View {
    var body: some View{
        TabView{
            ViewA()
                .tabItem(){
                    Image(systemName: "phone.fill")
                    Text("Calls")
                }
            ViewB()
                .tabItem(){
                    Image(systemName: "person.2.fill")
                    Text("Calls")
                }
            ViewC()
                .tabItem(){
                    Image(systemName: "person.fill")
                    Text("Calls")
                }
        }
    }
}

#Preview {
    ContentView()
}
