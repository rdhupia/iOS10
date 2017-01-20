//
//  PartyCellTVCell.swift
//  WebVideos
//
//  Created by Ravideep Dhupia on 2017-01-11.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit

class PartyCellTVCell: UITableViewCell {

    @IBOutlet weak var videoPrevewImage: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUI(data: DataModel) {
        videoTitle.text = data.videoTitle
        
        // Convert string to Swift URL object
        let url = URL(string: data.imageURL)!
        
        // Create new thread in the background to download images
        DispatchQueue.global().async {
            do {
                let contents = try Data(contentsOf: url)
                
                // Go back to main UI thread
                DispatchQueue.global().sync {
                    self.videoPrevewImage.image = UIImage(data: contents)
                }
            } catch {
                // handle error
            }
        }
        
    }

}
