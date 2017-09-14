//
//  ItemStore.swift
//  Homeowner
//
//  Created by Mimi Chenyao on 9/12/17.
//  Copyright © 2017 Mimi Chenyao. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    // Add URL where items will be saved to
    // Archived in application sandbox's /Documents directory
    let itemArchiveURL: URL = {
        
        // documentsDirectories is an array
        // FileManager.default.urls searches filesystem for /Documents folder
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first! // Get first (and only) item in array
        
        // Append archive file name to end of th is URL
        // "Documents/items.archive" or some shit like that is its final form
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    // Load files (deserialize) upon ItemStore initialization
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
            allItems = archivedItems
        }
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    // Changes order of items in allItems array
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Reference to selected item, so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        // Remove selected item from array
        allItems.remove(at: fromIndex)
        
        // Insert selected item into new location
        allItems.insert(movedItem, at: toIndex)
    }
    
    func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
    }
}
