//
//  DreamListVC.swift
//  DreamListCoreData
//
//  Created by Ravideep Dhupia on 2017-01-22.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit
import CoreData

class DreamListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    // MARK: CoreData: Work with NSFetchedResultsController
    var controller: NSFetchedResultsController<Item>!     // Kind of Data Classes to work with - Item
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: CoreData: Implement delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        // generateTestData()
        attemptFetch()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTVCell", for: indexPath) as! ItemTVCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    // Secondary configureCell func
    func configureCell(cell: ItemTVCell, indexPath: NSIndexPath) {
        
        // update cell
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }
    
    // Antime item in table view is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Confirm there is atleast one object
        if let objs = controller.fetchedObjects, objs.count > 0 {
            
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "ItemDetailsVC", sender: item)
        }
    }
    
    // Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ItemDetailsVC" {
            
            if let destination = segue.destination as? ItemDetailsVC {
                if let item = sender as? Item {
                    
                    destination.itemToEdit = item
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Grabbing sections out of the controller
        if let sections = controller.sections {
            
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = controller.sections {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // MARK: CoreData: Attempt to fetch data
    func attemptFetch() {
        
        // Create actual fetch request, tell it what we are fetching
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        // Tell FRC how to sort the data its fetching
        let dateSort = NSSortDescriptor(key: "createdDate", ascending: false)
        
        // Pass in the sort descriptor, expects an array
        fetchRequest.sortDescriptors = [dateSort]
        
        // Initialize controller
        // NSManagedObjectContext managed by persistance container in App Delegate, created shortcuts in AppDelegate to allow easy reference
        self.controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Assign controller delegate toself
        controller.delegate = self
        
        
        // Perform actual fetch
        // Fetch request can fail
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
            
        }
    }
    
    // Listen for changes and handle the changes
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemTVCell
                // Update cell data
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        }
    }
    
    // MARK: Generate test data
    func generateTestData() {
        
        let item = Item(context: context)
        item.title = "MacBook Pro"
        item.cost = 1900
        item.descrip = "16GB RAM, SSD, 13.3 inch retina display"
        
        let item2 = Item(context: context)
        item2.title = "Mercedes E-Class"
        item2.cost = 60000
        item2.descrip = "Mercedes Benz SUV"
        
        let item3 = Item(context: context)
        item3.title = "House"
        item3.cost = 250000
        item3.descrip = "Down payment for semi-detached house in Toronto"
        
        let item4 = Item(context: context)
        item4.title = "Dog"
        item4.cost = 2500
        item4.descrip = "Puppy labrador"
        
        ad.saveContext()
    }

}































































