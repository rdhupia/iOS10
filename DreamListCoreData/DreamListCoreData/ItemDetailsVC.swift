//
//  ItemDetailsVC.swift
//  DreamListCoreData
//
//  Created by Ravideep Dhupia on 2017-01-28.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var costField: CustomTextField!
    @IBOutlet weak var descripField: CustomTextField!
    
    @IBOutlet weak var thumbImage: UIImageView!

    // Array to hold Item Types
    var itemTypes = [ItemType]()
    
    // Item to edit
    var itemToEdit: Item?
    
    // Image picker
    var imagePicker: UIImagePickerController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        // Set delegate and data source
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        // Create Item Types
        /*
        let itemType = ItemType(context: context)
        itemType.type = "Long term Asset"
        
        let itemType2 = ItemType(context: context)
        itemType2.type = "Short term Asset"
        
        let itemType3 = ItemType(context: context)
        itemType3.type = "Service"
        
        let itemType4 = ItemType(context: context)
        itemType4.type = "Saving for purpose"
        
        let itemType5 = ItemType(context: context)
        itemType5.type = "Luxury"
        
        let itemType6 = ItemType(context: context)
        itemType6.type = "Travel"
        
        let itemType7 = ItemType(context: context)
        itemType7.type = "Payment"
        
        let itemType8 = ItemType(context: context)
        itemType8.type = "Miscellaneous"
 
        */
        // ad.saveContext()
        getItemTypes()
        
        if itemToEdit != nil {
            
            loadItemData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Conform to protocols for UIPickerView data source and delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let itemType = itemTypes[row]
        return itemType.type
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return itemTypes.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // Update when selected
    }
    
    // Create fetch request
    func getItemTypes() {
        
        // Create fetch request
        let fetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        
        // Perform fetch
        do {
            // Set the itemTypes arrar to the result
            self.itemTypes = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            // Handle error
        }
    }
    
    // Save button pressed
    @IBAction func savePressed(_ sender: UIButton) {
        
        // Only inserts new item
        // let item = Item(context: context)
        
        // To add edit functionality
        var item: Item!
        
        if itemToEdit == nil {
            
            // Add new item
            item = Item(context: context)
        } else {
            
            // If we did pass over an item
            item = itemToEdit
        }
        
        // Assign content from text fields to the attributes
        if let title = titleField.text {
            item.title = title
        }
        
        if let cost = costField.text {
            
            // MARK: Convert NSString to double
            item.cost = (cost as NSString).doubleValue
        }
        
        if let descrip = descripField.text {
            item.descrip = descrip
        }
        
        // Item type is an entity itself. Assigning an itemtype via relationship
        item.toItemType = itemTypes[storePicker.selectedRow(inComponent: 0)]    // This is column, not row. We only have one column
        
        ad.saveContext()
        
        // Dismiss view controller
        // MARK: After save, take back to main view controller
        _ = navigationController?.popViewController(animated: true)
    }
    
    // Load into text fields data from database
    func loadItemData() {
        
        if let item = itemToEdit {
            titleField.text = item.title
            costField.text = "\(item.cost)"
            descripField.text = item.descrip
            
            // Set the picker to the correct item type
            if let itemType = item.toItemType {
                
                var index = 0
                
                repeat {
                    
                    let i = itemTypes[index]
                    if i.type == itemType.type {
                        
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                    
                } while(index < itemTypes.count)
            }
        }
    }
    
    // Delete item
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _=navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Returns a dictionary of Any object
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            thumbImage.image = img
            
        }
    }
    
    
}







































