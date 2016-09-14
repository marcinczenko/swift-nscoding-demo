//
//  GeofenceCacheTests.swift
//  ruyterb
//
//  Created by Marcin Czenko on 14/09/16.
//  Copyright © 2016 Philips. All rights reserved.
//

import XCTest
import Nimble

@testable import swift_nscoding_demo


class GeofenceCacheTests: XCTestCase {
    
    private func getApplicationSupportDirectory() -> NSURL {
        
        return try! NSFileManager().URLForDirectory(
            .ApplicationSupportDirectory, inDomain: .UserDomainMask,
            appropriateForURL: nil, create: true)
    }
    
    func deleteFiles(fileURLs: [NSURL]) {
        for url in fileURLs {
            if NSFileManager().fileExistsAtPath(url.path!) {
                do {
                    try NSFileManager().removeItemAtURL(url)
                } catch {
                    // ignore silently :)
                }
            }
        }
    }
    
    private func createCacheWithTestItems() -> GeofenceCache {
        let geofenceCache = GeofenceCache()
        
        let testItems = [GeofenceCacheItem(id: "id1", geofence: "geofence1", status: "status1"),
                         GeofenceCacheItem(id: "id2", geofence: "geofence2", status: "status2")]
        
        geofenceCache.addCacheItem(testItems[0])
        geofenceCache.addCacheItem(testItems[1])
        
        return geofenceCache
    }
    
    private var testArchivePath: String {
        return getApplicationSupportDirectory().URLByAppendingPathComponent("TestArchiveName").path!
    }
    
    private var testArchiveURL: NSURL {
        return getApplicationSupportDirectory().URLByAppendingPathComponent("TestArchiveName")
    }

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCreatingAnInstanceOfGeofenceCache() {
        let geofenceCache = GeofenceCache()
        
        expect(geofenceCache).notTo(beNil())
    }
    
    func testRetreivingItemsFromEmptyCache() {
        let geofenceCache = GeofenceCache()
        
        expect(geofenceCache.items).to(equal([]))
    }
    
    func testAddingToAndRetrievingItemsFromCache() {
        let geofenceCache = GeofenceCache()
        
        let testItems = [GeofenceCacheItem(id: "id1", geofence: "geofence1", status: "status1"),
                         GeofenceCacheItem(id: "id2", geofence: "geofence2", status: "status2")]
        
        geofenceCache.addCacheItem(testItems[0])
        geofenceCache.addCacheItem(testItems[1])
        
        let items = geofenceCache.items
        
        expect(items).to(equal(testItems))
    }
    
    func testSerializingAndDeSerializingGeofenceCache() {
        let geofenceCache = createCacheWithTestItems()
        
        NSKeyedArchiver.archiveRootObject(geofenceCache, toFile: testArchivePath)
        
        // deserialization
        let deserialisedGeofenceCache = NSKeyedUnarchiver.unarchiveObjectWithFile(testArchivePath) as? GeofenceCache
        
        let i1 = geofenceCache.items
        let i2 = deserialisedGeofenceCache?.items
        
        print("geofenceCache.items=\(i1)")
        print("deserialisedGeofenceCache?.items=\(i2)")
        
        expect(geofenceCache.items).to(equal(deserialisedGeofenceCache?.items))
    }

}
