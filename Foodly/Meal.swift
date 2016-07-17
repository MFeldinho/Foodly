//
//  Meal.swift
//
//  Created by Marcel Felder on 02.07.16.
//  Copyright © 2016 XeriSoft. All rights reserved.
//

import UIKit

class Meal : NSObject, NSCoding {
    
    // MARK: Constants
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Initializers
    
    init?(name: String, photo: UIImage?, rating: Int) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        
        // Call designated initializer.
        self.init(name: name, photo: photo, rating: rating)
    }
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(self.photo, forKey: PropertyKey.photoKey)
        aCoder.encodeInteger(self.rating, forKey: PropertyKey.ratingKey)
    }
    
}