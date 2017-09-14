//
//  ImageStore.swift
//  Homeowner
//
//  Created by Mimi Chenyao on 9/14/17.
//  Copyright © 2017 Mimi Chenyao. All rights reserved.
//

import UIKit

/// ImageStore fetches/caches images as they are needed
/// Will flush cache if device is low on memory

class ImageStore {
    
    // NSCache automatically removes objects if memory is too low
    let cache = NSCache<NSString, UIImage>()
    
    /// All these functions cast String to NSString
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}
