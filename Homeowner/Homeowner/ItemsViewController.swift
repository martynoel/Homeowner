//
//  ItemsViewController.swift
//  Homeowner
//
//  Created by Mimi Chenyao on 9/12/17.
//  Copyright © 2017 Mimi Chenyao. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.rowHeight = 65 // Hard-coded
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    // Adding
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        // Create a new item and add it to the store
        let newItem = itemStore.createItem()
        
        // Figure out where that item is in the itemStore array
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            // Insert this row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Deleting
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // If the table view is asking to commit a delete command
        if editingStyle == .delete {
            
            // Remove from item store
            let item = itemStore.allItems[indexPath.row]
            itemStore.removeItem(item)
            
            // Delete row from table w/animation
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
    
    /// UITableViewDataSource protocol methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Custom cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let item = itemStore.allItems[indexPath.row]
        
        // Configure the cell with the item
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        if item.valueInDollars >= 50 {
            cell.valueLabel.textColor = UIColor.red
        } else {
            cell.valueLabel.textColor = UIColor.green
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        // "showItem" segue is triggered
        case "showItem"?:
            // Figure out which row was tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                
                // Get item associated with row, pass it along
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    // Called when VC before it is popped off the stack
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // Add "Edit" button to Nav Controller's left bar button
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
}
