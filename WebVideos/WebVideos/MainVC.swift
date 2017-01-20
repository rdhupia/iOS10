//
//  ViewController.swift
//  WebVideos
//
//  Created by Ravideep Dhupia on 2017-01-11.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit

// MARK: Table view: 1) Need to inherit from protocols - Delegate, DataSource
class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var dataModelsArray = [DataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
        // MARK: Table view: 2) Need to assign delegates
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: Table view: 3) Implement mandatory methods - cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PartyCell", for: indexPath) as? PartyCellTVCell {
            
            let dataModel = dataModelsArray[indexPath.row]
            cell.updateUI(data: dataModel)
            
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    // MARK: Table view: 4) Implement mandatory methods - numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // We'll have as many rows as items in the dataModelsArray
        return dataModelsArray.count
    }
    
    // MARK: Table view: not mandatory method of Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Grab DataModel object
        let dataModel = dataModelsArray[indexPath.row]
        performSegue(withIdentifier: "VideoVC", sender: dataModel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Grab destination view controller
        if let destination = segue.destination as? VideoVC {
            
            // Grab the sender, convert to DataModel object
            if let data = sender as? DataModel {
                // Set it in the dataModel object of the destination
                destination.dataModel = data
            }
        }
    }
    
    
    func loadData() {
        var imageUrl = "http://www.mjworld.net/wp-content/uploads/Black-Or-White-michael-jackson-12605065-918-1335.jpg"
        var videoUrl = "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/pTFE8cirkdQ\" frameborder=\"0\" allowfullscreen></iframe>"
        var videoTitle = "Black or Whitle"
        let vid1 = DataModel(imageURL: imageUrl, videoURL: videoUrl, videoTitle: videoTitle)
        
        dataModelsArray.append(vid1)
        
        imageUrl = "http://img.wennermedia.com/article-leads-horizontal/rs-13177-thriller-624-1382985460.jpg"
        videoUrl = "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/sOnqjkJTMaA\" frameborder=\"0\" allowfullscreen></iframe>"
        videoTitle = "Thriller"
        let vid2 = DataModel(imageURL: imageUrl, videoURL: videoUrl, videoTitle: videoTitle)
        
        dataModelsArray.append(vid2)
        
        imageUrl = "https://s-media-cache-ak0.pinimg.com/originals/65/73/7c/65737cf68695d7052b52cd866b4244d0.jpg"
        videoUrl = "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/h_D3VFfhvs4\" frameborder=\"0\" allowfullscreen></iframe>"
        videoTitle = "Smooth Criminal"
        let vid3 = DataModel(imageURL: imageUrl, videoURL: videoUrl, videoTitle: videoTitle)
        
        dataModelsArray.append(vid3)
        
        imageUrl = "https://s-media-cache-ak0.pinimg.com/originals/a9/0e/8e/a90e8e442c08e5c060faa2eff91bc358.jpg"
        videoUrl = "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/Ym0hZG-zNOk\" frameborder=\"0\" allowfullscreen></iframe>"
        videoTitle = "Beat It"
        let vid4 = DataModel(imageURL: imageUrl, videoURL: videoUrl, videoTitle: videoTitle)
        
        dataModelsArray.append(vid4)
        
        imageUrl = "http://vignette2.wikia.nocookie.net/michaeljackson/images/0/0e/Billie_Jean.jpg"
        videoUrl = "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/Zi_XLOBDo_Y\" frameborder=\"0\" allowfullscreen></iframe>"
        videoTitle = "Billie Jean"
        let vid5 = DataModel(imageURL: imageUrl, videoURL: videoUrl, videoTitle: videoTitle)
        
        dataModelsArray.append(vid5)
        
    }
    


}

