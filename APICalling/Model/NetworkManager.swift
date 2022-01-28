//
//  NetworkManager.swift
//  APICalling
//
//  Created by TudipTech on 27/01/22.
//

import Foundation
class NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
    var structure : [structure] = []
    var defaultSession = URLSession(configuration: .default)
    var dataTask : URLSessionDataTask?
    var errorMessage = ""
    
    
    func callStructAPI(onCompletion: @escaping (Bool, String?) -> Void)  {
        dataTask?.cancel()
        
        guard let url = URL(string: loginURL) else { return }
        
        dataTask = defaultSession.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
               // print("hello")
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    onCompletion(false, error.localizedDescription)
                }
            } else if let data  = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.parseFromResponse(json: data)
                DispatchQueue.main.async {
                    onCompletion(true, self.errorMessage)
                }
            }
        })
        dataTask?.resume()
    }
    
   
    func parseFromResponse(json: Data) {
        var response : [Any]?
        
        do {
            response =  try JSONSerialization.jsonObject(with: json, options: []) as? [Any]
        } catch let error as NSError {
            self.errorMessage = error.localizedDescription
        }
      
        guard let responseArray = response else { return }

        
        for responseDict in responseArray {
                   if let structDict = responseDict as? [String : Any],
                    let structimage = structDict["img"] as? String,
                    let name = structDict["name"] as? String
                    {
                       self.structure.append(APICalling.structure(name: name, img: structimage))
                       //self.structure.append(APICalling.structure(name: name, img: structimage))
            }
        }
    }
    func fetchCellImage(structobj: structure, onCompletion: @escaping (Data, structure) -> Void) {
        DispatchQueue.global().async {
            
            var dataTask : URLSessionDataTask?
            dataTask?.cancel()
           guard let img = structobj.img else { return }
           guard let url = URL(string: img) else { return }
           
           dataTask = self.defaultSession.dataTask(with:url , completionHandler: { (imageData, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                  
                } else if let data = imageData {
                    print("Did download image data")
                    DispatchQueue.main.async {
                        onCompletion(data, structobj)
                    }
                }
            })
            dataTask?.resume()
        }
    }
}
