//
//  ImageStore.swift
//  Homeowner
//
//  Created by Mimi Chenyao on 9/14/17.
//  Copyright © 2017 Mimi Chenyao. All rights reserved.
//

import UIKit

/// ImageStore stores images to conserve memory.
/// Fetches/caches images as they are needed
/// Will flush cache if device is low on memory

class ImageStore {
    
    // MARK: Properties
    
    // NSCache automatically removes objects if memory is too low
    let cache = NSCache<NSString, UIImage>()
    
    // MARK: Image storing methods
    
    /// All these functions cast String to NSString
    
    // Puts image in cache
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        
        // Create full URL for image
        let url = imageURL(forKey: key)
        
        // Turn image into JPEG data
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            // Write to full URL in filesystem
            try? data.write(to: url, options: [.atomic])
        }
    }
    
    // Fetches image from file system or cache
    func image(forKey key: String) -> UIImage? {
        
        // If image already exists, return it
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        
        // Otherwise, construct URL that corresponds to UUID.jpeg of image
        let url = imageURL(forKey: key)
        // Try to read image from URL (if you can't, just return)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        // Store image in cache if it exists
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    // Deletes image from both store AND filesystem
    func deleteImage(forKey key: String) {
        // Delete from store
        cache.removeObject(forKey: key as NSString)
        
        // Set item to url and delete from filesystem too
        let url = imageURL(forKey: key)
        // Use do-catch statement to call a method that can throw
        do {
            try FileManager.default.removeItem(at: url)
        } catch let deleteError {
            print("Error removing image from disk: \(deleteError)")
        }
    }
    
    // Create URL in documents directory by using given key
    func imageURL(forKey key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
    }
}
