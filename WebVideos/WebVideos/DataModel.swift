//
//  DataModel.swift
//  WebVideos
//
//  Created by Ravideep Dhupia on 2017-01-11.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import Foundation

class DataModel {
    private var _imageURL: String!
    private var _videoURL: String!
    private var _videoTitle: String!
    
    // Getters
    var imageURL: String {
        return _imageURL
    }
    
    var videoURL: String {
        return _videoURL
    }
    
    var videoTitle: String {
        return _videoTitle
    }
    
    // Initializer
    init(imageURL: String, videoURL: String, videoTitle: String) {
        _imageURL = imageURL
        _videoURL = videoURL
        _videoTitle = videoTitle
        
    }
}
