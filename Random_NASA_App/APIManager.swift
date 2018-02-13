//
//  APIManager.swift
//  Rest_Swift_Example
//
//  Created by PointMotion on 2/12/18.
//  Copyright © 2018 Andrew Perrin. All rights reserved.
//

import Foundation
import UIKit


class APIManager {
    static let sharedInstance = APIManager()

    func getPostWithId(postDate: String, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = "https://api.nasa.gov/planetary/apod?date=\(postDate)&api_key=XjzLLISb9QIcEuFPzKtMCtteOTrphfBBQCDfG4RJ"
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do {
                    let result = try JSON(data: data!)
                    onSuccess(result)
                }
                catch _ {
                    // Error handling
                }
                
                
            }
        })
        task.resume()
    }
}
