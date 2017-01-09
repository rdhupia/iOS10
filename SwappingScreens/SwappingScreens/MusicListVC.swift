//
//  MusicListVC.swift
//  SwappingScreens
//
//  Created by Ravideep Dhupia on 2017-01-03.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit

class MusicListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blue
    }
    
    // Better than creating a segue from the button to the login view
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func loadThirdScenePressed(_ sender: Any) {
        
        // Anything could have been passed in sender: array, string, dictionary etc.
        performSegue(withIdentifier: "SongVC", sender: "Quit Playing Games With My Heart")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PlaySongVC {
            
            if let song = sender as? String {
                destination.selectedSong = song
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
