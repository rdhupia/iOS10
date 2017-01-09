//
//  PlaySongVC.swift
//  SwappingScreens
//
//  Created by Ravideep Dhupia on 2017-01-03.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit

class PlaySongVC: UIViewController {

    @IBOutlet weak var songTitleLabel: UILabel!
    
    private var _selectedSong: String!
    
    var selectedSong: String {
        get {
            return _selectedSong
        } set {
            _selectedSong = newValue
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.cyan
        songTitleLabel.text = _selectedSong
    }

   
}
