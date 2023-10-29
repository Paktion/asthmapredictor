import Foundation
import SwiftUI
struct Pf:Codable{
    let value:Float
}
enum GHError: Error{
    case invalidURL
    case invalidResponse
    case invalidData
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
            if user?.value ?? 0 >= 0 && user?.value ?? 0 < 0.50{
                Color(UIColor.darkGray).ignoresSafeArea()
                Text("Peak Flow")
                    .font(.system(size: 35, weight: .bold)).multilineTextAlignment(.center).position(x: 197, y: 150).foregroundColor(Color(UIColor.systemGray5))

                Image("redt").resizable().frame(width: 300, height: 300)
                Text(String(format: "%.0f%%",(user?.value ?? 0)*100))
                    .font(.system(size: 35, weight: .bold)).position(x:197,y:530).foregroundColor(Color(UIColor.systemGray5))
            }
            else if user?.value ?? 0 >= 0.50 && user?.value ?? 0 < 0.60{
                Color(UIColor.darkGray).ignoresSafeArea()
                Text("Peak Flow")
                    .font(.system(size: 35, weight: .bold)).multilineTextAlignment(.center).position(x: 197, y: 150).foregroundColor(Color(UIColor.systemGray5))

                Image("oranget").resizable().frame(width: 300, height: 300)
                Text(String(format: "%.0f%%",(user?.value ?? 0)*100))
                    .font(.system(size: 35, weight: .bold)).position(x:197,y:530).foregroundColor(Color(UIColor.systemGray5))
            }
            else if user?.value ?? 0 >= 0.60 && user?.value ?? 0 < 0.70{
                Color(UIColor.darkGray).ignoresSafeArea()
                Text("Peak Flow")
                    .font(.system(size: 35, weight: .bold)).multilineTextAlignment(.center).position(x: 197, y: 150).foregroundColor(Color(UIColor.systemGray5))

                Image("yellowt").resizable().frame(width: 300, height: 300)
                Text(String(format: "%.0f%%",(user?.value ?? 0)*100))
                    .font(.system(size: 35, weight: .bold)).position(x:197,y:530).foregroundColor(Color(UIColor.systemGray5))
            }
            else if user?.value ?? 0 >= 0.70 && user?.value ?? 0 < 0.80{
                Color(UIColor.darkGray).ignoresSafeArea()
                Text("Peak Flow")
                    .font(.system(size: 35, weight: .bold)).multilineTextAlignment(.center).position(x: 197, y: 150).foregroundColor(Color(UIColor.systemGray5))

                Image("lightgreent").resizable().frame(width: 300, height: 300)
                Text(String(format: "%.0f%%",(user?.value ?? 0)*100))
                    .font(.system(size: 35, weight: .bold)).position(x:197,y:530).foregroundColor(Color(UIColor.systemGray5))
            }else if user?.value ?? 0 >= 0.80 {
                Color(UIColor.darkGray).ignoresSafeArea()
                Text("Peak Flow")
                    .font(.system(size: 35, weight: .bold)).multilineTextAlignment(.center).position(x: 197, y: 150).foregroundColor(Color(UIColor.systemGray5))

                Image("greent").resizable().frame(width: 300, height: 300)
                Text(String(format: "%.0f%%",(user?.value ?? 0)*100))
                    .font(.system(size: 35, weight: .bold)).position(x:197,y:530).foregroundColor(Color(UIColor.systemGray5))
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
                user = try await getPf(url: "http://127.0.0.1:5000/22.0/15.0/15.0/11.0/1040.0/98.0/2.51/0.0/2.0/283.72/20.39/21.99/2.27/11.64/16.40/0.39/83.0")
                try await Task.sleep(nanoseconds: 1_000_000_000)
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
                try await Task.sleep(nanoseconds: 1_000_000_000)
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
                user = try await getPf(url: "http://127.0.0.1:5000/22.0/15.0/15.0/16.0/1040.0/98.0/2.51/0.0/2.0/283.72/20.39/21.99/2.27/11.64/16.40/0.39/83.0")
                try await Task.sleep(nanoseconds: 1_000_000_000)
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
                user = try await getPf(url: "http://127.0.0.1:5000/22.0/15.0/15.0/13.0/1040.0/98.0/2.51/0.0/2.0/283.72/20.39/21.99/2.27/11.64/16.40/0.39/83.0")
                try await Task.sleep(nanoseconds: 1_000_000_000)
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
                try await Task.sleep(nanoseconds: 1_000_000_000)
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
                try await Task.sleep(nanoseconds: 1_000_000_000)
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
                try await Task.sleep(nanoseconds: 1_000_000_000)
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
                try await Task.sleep(nanoseconds: 1_000_000_000)
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

struct ViewTrends: View{
    var body: some View{
        ZStack{
            Color(UIColor.darkGray).ignoresSafeArea()
        }
    }
}

struct ViewFamily: View{
    var body: some View{
        ZStack{
            Color(UIColor.darkGray).ignoresSafeArea()
        }
    }
}

struct ViewInfo: View{
    var body: some View{
        ZStack{
            Color(UIColor.darkGray).ignoresSafeArea()
        }
    }
}

struct ContentView: View {
    var body: some View{
        TabView{
            Home()
                .tabItem(){
                    Image(systemName: "lungs.fill")
                    Text("Home")
                }.toolbarBackground(Color.white, for: .tabBar)
            ViewTrends()
                .tabItem(){
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Trends")
                }.toolbarBackground(Color.white, for: .tabBar)
            ViewFamily()
                .tabItem(){
                    Image(systemName: "person.2")
                    Text("Family")
                }.toolbarBackground(Color.white, for: .tabBar)
            ViewInfo()
                .tabItem(){
                    Image(systemName: "info.circle")
                    Text("Info")
                }.toolbarBackground(Color.white, for: .tabBar)
        }
    }
}

#Preview {
    ContentView()
}
