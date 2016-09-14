//
//  GeofenceCache.swift
//  ruyterb
//
//  Created by Marcin Czenko on 14/09/16.
//  Copyright © 2016 Philips. All rights reserved.
//

import Foundation

class GeofenceCache: NSObject, NSCoding {
    private var _items: NSMutableArray
    
    var items: [GeofenceCacheItem] {
        return _items.flatMap({ $0 as? GeofenceCacheItem })
    }
    
    override init() {
        _items = NSMutableArray()
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        if let items = aDecoder.decodeObjectForKey("cacheItems") as? NSArray {
            _items = NSMutableArray(array: items)
        } else {
            _items = NSMutableArray()
        }
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(_items as NSArray, forKey: "cacheItems")
    }
    
    func addCacheItem(cacheItem: GeofenceCacheItem) {
        _items.addObject(cacheItem)
    }
}
