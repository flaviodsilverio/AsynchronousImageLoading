//
//  APIConnection.swift
//  AsynchronousImagesOnTableViewCells
//
//  Created by Flávio Silvério on 7/21/16.
//  Copyright © 2016 Flavio Silverio. All rights reserved.
//

import Foundation
import UIKit

protocol APIConnectionDelegate {

}

class APIConnection: Any {
    
    var delegate : APIConnectionDelegate?
    
    func loadImage(index: NSIndexPath, completion:(success: Bool, image: UIImage?, imageIndexPath: NSIndexPath)->()){
        
        let request = NSURLRequest(URL: NSURL(string: "https://api.adorable.io/avatars/75/\(String.randomString(10))")!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            // notice that I can omit the types of data, response and error
            
            // your code
            if error == nil {
                
                let image = UIImage(data: data!)
                completion(success: true, image: image, imageIndexPath: index)

            } else {
                
                completion(success: false, image: nil, imageIndexPath: index)

            }
            
        });
        
        task.resume()
        
    }
    
}

extension String {
    
    static func randomString(withSize: Int) -> String{
        
        let allCharacters : [Character] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
        var stringToReturn = ""
        
        while stringToReturn.characters.count < withSize {
            stringToReturn.append(allCharacters[Int(arc4random_uniform(UInt32(allCharacters.count)))])
        }
        
        return stringToReturn
    }
    
}