import Foundation

func fetchDataFromFlaskServer(completion: @escaping (String?, Error?) -> Void) {
    if let url = URL(string: "http://127.0.0.1:5000/22.0/2.54/0.77/4.84/1040.0/98.0/0.51/0.0/2.0/283.72/20.39/21.99/2.27/11.64/16.40/0.39/83.0") {
        let task = URLSession.shared.dataTask(with: url){
            (data, response, error) in
            if let error = error {
                completion(nil, error)
            }

            if let data = data {
                            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                completion(nil, json)
                }
        }

        task.resume()
    } else {
        completion(nil, NSError(domain: "InvalidURL", code: 3, userInfo: nil))
    }
}


