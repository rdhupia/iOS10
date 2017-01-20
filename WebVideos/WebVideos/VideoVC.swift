//
//  VideoVC.swift
//  WebVideos
//
//  Created by Ravideep Dhupia on 2017-01-11.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit

class VideoVC: UIViewController {

    // wk web view is the new web view, needs to be imported programatically
    // using exisiting ui web view here
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var videoTitle: UILabel!
    
    private var _dataModel: DataModel!
    
    var dataModel: DataModel {
        get {
            return _dataModel
        } set {
            _dataModel = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTitle.text = dataModel.videoTitle
        webView.loadHTMLString(dataModel.videoURL, baseURL: nil)

    }

    

}
