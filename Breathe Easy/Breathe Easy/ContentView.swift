//
//  ContentView.swift
//  Breathe Easy
//
//  Created by Amogh Kuppa on 10/28/23.
//

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

import SwiftUI

struct ContentView: View {
    func getPf() async throws -> Pf{
        let endpoint = "http://127.0.0.1:5000/22.0/2.54/0.77/4.84/1040.0/98.0/0.51/0.0/2.0/283.72/20.39/21.99/2.27/11.64/16.40/0.39/83.0"
        
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
            if user?.value ?? 0 >= 0 && user?.value ?? 0 <= 0.30{
                ContainerRelativeShape().fill(.red.gradient)
                    .ignoresSafeArea()
                VStack {
                    Text("Your Peak Flow Percentage")
                        .font(.system(size: 30, weight: .bold))
                        .position(x:197, y:200)
                    Image(systemName: "lungs")
                        .imageScale(.large)
                        .foregroundColor(.black)
                    Text("\(user?.value ?? 0) %")
                        .font(.title2)
                    Text("Your Peak Flow has fallen below 50% of your predicted. You may be at severe risk of an asthma attack").font(.title3).multilineTextAlignment(.center)
                        .position(x:197, y:200)
                }
                
            }
            else if user?.value ?? 0 > 0.50 && user?.value ?? 0 < 0.70{
                ContainerRelativeShape().fill(.yellow.gradient)
                    .ignoresSafeArea()
                VStack {
                    Text("Your Peak Flow Percentage")
                        .font(.system(size: 24, weight: .bold))
                    Image(systemName: "lungs")
                        .imageScale(.large)
                        .foregroundColor(.black)
                    Text("\(user?.value ?? 0) %")
                        .font(.title2)
                    Text("Your Peak Flow is between 50% and 80% of your personal best. You may be at moderate risk of an asthma attack")
            }
            }
            else if user?.value ?? 0 > 0.70 && user?.value ?? 0 <= 1.0{
                ContainerRelativeShape().fill(.green.gradient)
                    .ignoresSafeArea()
                VStack {
                    Text("Your Peak Flow Percentage")
                        .font(.system(size: 24, weight: .bold))
                    Image(systemName: "lungs")
                        .imageScale(.large)
                        .foregroundColor(.black)
                    Text("\(user?.value ?? 0) %")
                        .font(.title2)
                    Text("Your Peak Flow is above 80% of your personal best. You can breathe easy")
            }
            }
            
        }
        
        .task{
            do{
                user = try await getPf()
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

#Preview {
    ContentView()
}
