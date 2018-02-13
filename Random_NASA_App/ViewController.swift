//
//  ViewController.swift
//  Rest_Swift_Example
//
//  Created by PointMotion on 2/12/18.
//  Copyright © 2018 Andrew Perrin. All rights reserved.
//

import UIKit


class ViewController: UIViewController, ModelDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var articleDateLabel: UITextView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var dataView: UITextView!
    let model = Model()
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        title = "Random Nasa Info"
        
    }

    func successCallback() {
        self.titleTextView?.text = model.articleTitle
        self.dataView?.text = model.articleText
        self.articleDateLabel?.text = model.articleDate
        if (model.articleImage != nil){
            imageView.image = UIImage(data: model.articleImage)
        }
        else {
            imageView.image = UIImage(named: "ErrorImage")
        }
    }
    
    @IBAction func getDataPressed(_ sender: UIButton) {
        self.model.getData()
    }
}
