//
//  SecondViewController.swift
//  UdemyFortyThree
//
//  Created by Ravideep Dhupia on 2016-12-31.
//  Copyright © 2016 Ravideep Dhupia. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var images = [UIImageView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        var contentWidth: CGFloat = 0.0
        let scrollWidth = scrollView.frame.size.width
        
        for x in 0..<3 {
            let image = UIImage(named: "icon\(x).png")
            let imageView = UIImageView(image: image)
            images.append(imageView)
            
            // First will be in the centre, second one in the centre but whole screen to the right
            // Move over by full width of the scroll view
            // (because in this case its the same width of the full screen)
            var newX: CGFloat = 0.0
            newX = scrollWidth / 2 + scrollWidth * CGFloat(x)
            
            contentWidth += scrollWidth
            
            // Add subview
            scrollView.addSubview(imageView)
            
            // Set frame on the image view
            imageView.frame = CGRect(x: newX - 75, y: (scrollView.frame.size.height / 2) - 75, width: 150, height: 150)
            
        }
        
        scrollView.clipsToBounds = false
        
        // Set conent size for the scroll view (it will be more than screen size)
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
        
        // Add Gesture Recognizer. Swiping the sides will have the same gesture recongnizer as the UIScrollView
        view.addGestureRecognizer(scrollView.panGestureRecognizer)
        
        print("Count: \(images.count)")

    }
    

}
