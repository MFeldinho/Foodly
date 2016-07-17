//
//  ShoppingListItem.swift
//
//  Created by Marcel Felder on 14.07.16.
//  Copyright © 2016 XeriSoft. All rights reserved.
//

import UIKit

class ShoppingListItem : NSObject, NSCoding {
    
    // MARK: Constants
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("shoppinglistitems")
    
    // MARK: Properties
    
    var uuid: String
    var name: String
    var amount: Int32
    var price: Float?
    var inShoppingList: Bool
    
    // MARK: Initializers
    
    init?(uuid: String, name: String, amount: Int32, price: Float?, inShoppingList: Bool) {
        self.uuid = uuid
        self.name = name
        self.amount = amount
        self.price = price
        self.inShoppingList = inShoppingList
        
        super.init()
        
        if name.isEmpty || amount < 0 {
            return nil
        }
    }
    
    convenience init?(name: String, amount: Int32, price: Float?, inShoppingList: Bool) {
        self.init(uuid: NSUUID().UUIDString, name: name, amount: amount, price: price, inShoppingList: inShoppingList)
    }
    
    required convenience init?(coder decoder: NSCoder) {
        let uuid = decoder.decodeObjectForKey(PropertyKey.idKey) as! String
        let name = decoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let amount = decoder.decodeObjectForKey(PropertyKey.amountKey) as! Int32
        let price = decoder.decodeObjectForKey(PropertyKey.priceKey) as? Float
        let inShoppingList = decoder.decodeObjectForKey(PropertyKey.inShoppingListKey) as! Bool
        
        // Call designated initializer
        self.init(uuid: uuid, name: name, amount: amount, price: price, inShoppingList: inShoppingList)
    }
    
    // MARK: Types
    
    struct PropertyKey {
        static let idKey = "uuid"
        static let nameKey = "name"
        static let amountKey = "amount"
        static let priceKey = "price"
        static let inShoppingListKey = "inShoppingList"
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.uuid, forKey: PropertyKey.idKey)
        aCoder.encodeObject(self.name, forKey: PropertyKey.nameKey)
        aCoder.encodeInt32(self.amount, forKey: PropertyKey.amountKey)
        aCoder.encodeFloat(self.price!, forKey: PropertyKey.priceKey)
        aCoder.encodeBool(self.inShoppingList, forKey: PropertyKey.inShoppingListKey)
    }

}