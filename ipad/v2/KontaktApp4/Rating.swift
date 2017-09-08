//
//  Meal.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/10/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit


class Rating {
    
    //MARK: Properties
    
    var firstname: String
    var name: String
    var rating: CosmosView
    var comment: UITextField
    
    //MARK: Initialization
    
    init?(firstname: String, name: String, rating: CosmosView, comment: UITextField) {

        
        // Initialize stored properties.
        self.firstname = firstname
        self.name = name
        self.rating = rating
        self.comment = comment
        
    }
}
