//
//  GeofenceCacheItemTests.swift
//  ruyterb
//
//  Created by Marcin Czenko on 14/09/16.
//  Copyright © 2016 Philips. All rights reserved.
//

import XCTest
import Nimble

@testable import swift_nscoding_demo


class GeofenceCacheItemTests: XCTestCase {
    
    let testArchiveName = "GeofenceCacheItem"
    
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
        deleteFiles([testArchiveURL])
        super.tearDown()
    }
    
    func testCreatingAnInstanceOfGeofenceCacheItem() {
        let geofenceCacheItem = GeofenceCacheItem(id: "id", geofence: "geofence", status: "status")
        
        expect(geofenceCacheItem).notTo(beNil())
    }
    
    func testSerializingAndDeSerializingGeofenceCacheItem() {
        
        // serialization
        let geofenceCacheItem = GeofenceCacheItem(id: "id", geofence: "geofence", status: "status")
        
        NSKeyedArchiver.archiveRootObject(geofenceCacheItem, toFile: testArchivePath)
        
        // deserialization
        let deserialisedGeofenceCacheItem = NSKeyedUnarchiver.unarchiveObjectWithFile(testArchivePath) as? GeofenceCacheItem
        
        expect(deserialisedGeofenceCacheItem).notTo(beNil())
        expect(deserialisedGeofenceCacheItem?.id).to(equal(geofenceCacheItem.id))
        expect(deserialisedGeofenceCacheItem?.geofence).to(equal(geofenceCacheItem.geofence))
        expect(deserialisedGeofenceCacheItem?.status).to(equal(geofenceCacheItem.status))
    }
}
