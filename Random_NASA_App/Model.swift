//
//  Model.swift
//  Rest_Swift_Example
//
//  Created by PointMotion on 2/12/18.
//  Copyright © 2018 Andrew Perrin. All rights reserved.
//

import Foundation
import MobileCoreServices

class Model : NSObject {
    
    var articleText:String?
    var articleTitle:String?
    var articleDate:String?
    var articleImage:Data!

    weak var delegate: ModelDelegate?
    
    override init() {
        super.init()
        getData()
    }
    
    func getData() {
        
        let randomDate = self.getRandomDate()
        print(randomDate)
        
        APIManager.sharedInstance.getPostWithId(postDate: randomDate, onSuccess: { json in
            DispatchQueue.main.async {
                let explanation = json["explanation"].string
                let title = json["title"].string
                let date = json["date"].string
                let imageURL = json["url"].string
                if (imageURL != nil){
                    let fileExtension = NSURL(fileURLWithPath: imageURL!).pathExtension
                    let uti = UTTypeCreatePreferredIdentifierForTag(
                        kUTTagClassFilenameExtension,
                        fileExtension! as CFString,
                    nil)
                    if UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypeImage) {
                        if (imageURL != nil){
                            let url = URL(string: imageURL!)
                            let imageData = try? Data(contentsOf: url!)
                            print("Successful Image Load")
                            self.articleImage = imageData
                        }
                        else {
                            print("FAILURE TO LOAD IMAGE")
                            self.articleImage = nil
                        }
                    }
                    else {
                        print("this is not an image")
                        self.articleImage = nil
                    }
                }
                else {
                    self.articleImage = nil
                }

                self.articleDate = date
                self.articleTitle = title
                self.articleText = explanation
                self.delegate?.successCallback()
            }
        }, onFailure: { error in
            print("failure")
        })
    }
    
    func getRandomDate() -> String {
        let A: UInt32 = 1 // UInt32 = 32-bit positive integers (unsigned)
        let B: UInt32 = 12
        let randomMonth = arc4random_uniform(B - A + 1) + A
        
        let A2: UInt32 = 1 // UInt32 = 32-bit positive integers (unsigned)
        let B2: UInt32 = 29
        let randomDay = arc4random_uniform(B2 - A2 + 1) + A2
        
        let A3: UInt32 = 2011 // UInt32 = 32-bit positive integers (unsigned)
        let B3: UInt32 = 2017
        let randomYear = arc4random_uniform(B3 - A3 + 1) + A3
        
        let date = "\(randomYear)-\(randomMonth)-\(randomDay)"
        return date
    }
}

protocol ModelDelegate: class {
    func successCallback()
}
