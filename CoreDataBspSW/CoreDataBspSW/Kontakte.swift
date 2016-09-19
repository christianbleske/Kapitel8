//
//  Kontakte.swift
//  CoreDataBspSW
//
//  Created by Christian Bleske on 23.10.14.
//  Copyright (c) 2014 Christian Bleske. All rights reserved.
//

import Foundation
import CoreData

class Kontakte: NSManagedObject {

    @NSManaged var nachname: String
    @NSManaged var ort: String
    @NSManaged var plz: String
    @NSManaged var strasse: String
    @NSManaged var vorname: String

}
