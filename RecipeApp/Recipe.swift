//
//  Recipe.swift
//  RecipeApp
//
//  Created by Martin Abel on 11.04.16.
//  Copyright © 2016 Martin Abel. All rights reserved.
//

import Foundation
import CoreData

class Recipe: NSManagedObject {
    
    @NSManaged var name:String?
    @NSManaged var instructions:String?
    
}
