//
//  RecipeDetailViewController.swift
//  RecipeApp
//
//  Created by Martin Abel on 14.04.16.
//  Copyright © 2016 Martin Abel. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var instructions: UILabel!
    
    var recipeDetails: Recipe?
    
    func loadViewDetails(){
        if let recipeDetails = self.recipeDetails {
            self.title = recipeDetails.name
            self.instructions.text = recipeDetails.instructions
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}