//
//  GeofenceCacheItem.swift
//  ruyterb
//
//  Created by Marcin Czenko on 14/09/16.
//  Copyright © 2016 Philips. All rights reserved.
//

import Foundation

class GeofenceCacheItem: NSObject, NSCoding {
    
    let id: String
    let geofence: String
    let status: String
    
    override var description: String {
        return "{ id: \(id), geofence: \(geofence), " +
            "status: \(status) }"
    }
    
    init(id: String, geofence: String, status: String) {
        self.id = id
        self.geofence = geofence
        self.status = status
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.id = aDecoder.decodeObjectForKey("id") as? String ?? ""
        self.geofence = aDecoder.decodeObjectForKey("geofence") as? String ?? ""
        self.status = aDecoder.decodeObjectForKey("status") as? String ?? ""
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(geofence, forKey: "geofence")
        aCoder.encodeObject(status, forKey: "status")
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let right = object as? GeofenceCacheItem {
            return self.id == right.id &&
                self.status == right.status &&
                self.geofence == right.geofence
        }
        return false
    }
    
    override var hash: Int {
        return status.hashValue ^ geofence.hashValue ^ id.hashValue
    }
}
