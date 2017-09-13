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
}
