//
//  Model.swift
//  MyShoppingList
//
//  Created by Mohamed El-Alfy on 2/9/15.
//  Copyright (c) 2015 Mohamed El-Alfy. All rights reserved.
//

import UIKit
import CoreData


@objc(Model)
class Model: NSManagedObject {
    
    @NSManaged var item:String
    @NSManaged var quantity:String
    @NSManaged var info:String
    
}
