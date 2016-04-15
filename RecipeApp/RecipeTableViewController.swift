//
//  RecipeTableViewController.swift
//  RecipeApp
//
//  Created by Martin Abel on 11.04.16.
//  Copyright © 2016 Martin Abel. All rights reserved.
//

import UIKit
import CoreData

class RecipeTableViewController: UITableViewController, UISearchResultsUpdating {

    var recipes = [Recipe]()
    var filteredRecipes = [Recipe]()
    var recipeDetailViewController: RecipeDetailViewController? = nil
    let searchController = UISearchController(searchResultsController: nil)
    
    var managedObjectContext: NSManagedObjectContext? = nil
    
    //dummy recipes, should be replaced with fetching an recipe webservice or something else
    func loadDummyRecipes() -> [Recipe]{
        
        var tmpRecipes = [Recipe]()
        let entity =  NSEntityDescription.entityForName("Recipe", inManagedObjectContext:managedObjectContext!)
        
        let rec1 = Recipe(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        rec1.name = "Pizza Pinwheels"
        rec1.instructions = "Preheat oven to 375 degrees F (190 degrees C). On a large baking sheet, pinch the 8 crescent roll dough triangles into 4 rectangles. Layer each rectangle with 6 slices of pepperoni and even amounts of mozzarella cheese. Roll tightly lengthwise and slice each into 4 or more pieces. Bake in the preheated oven until golden brown, about 12 minutes. Serve with pizza sauce for dipping."
        let rec2 = Recipe(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        rec2.name = "Baked Teriyaki Chicken"
        rec2.instructions = "In a small saucepan over low heat, combine the cornstarch, cold water, sugar, soy sauce, vinegar, garlic, ginger and ground black pepper. Let simmer, stirring frequently, until sauce thickens and bubbles.Preheat oven to 425 degrees F (220 degrees C).Place chicken pieces in a lightly greased 9x13 inch baking dish. Brush chicken with the sauce. Turn pieces over, and brush again.Bake in the preheated oven for 30 minutes. Turn pieces over, and bake for another 30 minutes, until no longer pink and juices run clear. Brush with sauce every 10 minutes during cooking."
        let rec3 = Recipe(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        rec3.name = "'Day Before Payday' Kielbasa and Corn Hash"
        rec3.instructions = "Heat 1 tablespoon of canola oil in a large skillet over medium-high heat. Stir in the potatoes and kielbasa, and cook until the kielbasa is browned, and the potatoes are nearly tender, about 10 minutes. Add the frozen pepper mix and corn; season with red pepper flakes, salt, and pepper to taste. Cook, stirring occasionally, until the mixture is hot and the potatoes are tender, about 10 minutes more.Meanwhile, heat the remaining 2 tablespoons of canola oil in a large skillet over medium heat. Once hot, crack in the eggs, and cook to your desired degree of doneness, about 1 1/2 minutes per side for over-medium. Portion the kielbasa hash into 6 servings, and top each serving with a fried egg."
        let rec4 = Recipe(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        rec4.name = "Garlic Chicken Fragrant Rice On a Budget"
        rec4.instructions = "Place rice, water, sesame oil, chicken bouillon, olive oil, green onion, garlic and ginger in a rice cooker. Stir, and then place chicken thigh on top. Turn on rice cooker.When the rice is done, mix the rice so that the oil will be evenly mixed with the rice. Serve."
        let rec5 = Recipe(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        rec5.name = "Greek Pasta with Tomatoes and White Beans"
        rec5.instructions = "Cook the pasta in a large pot of boiling salted water until al dente.Meanwhile, combine tomatoes and beans in a large non-stick skillet. Bring to a boil over medium high heat. Reduce heat, and simmer 10 minutes.Add spinach to the sauce; cook for 2 minutes or until spinach wilts, stirring constantly.Serve sauce over pasta, and sprinkle with feta."
        let rec6 = Recipe(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        rec6.name = "Dixie Pork Chops"
        rec6.instructions = "Preheat the oven to 350 degrees F (175 degrees C). Heat the oil in a large skillet over medium-high heat. Fry pork chops on each side until browned, about 3 minutes per side. Transfer to a baking dish, reserving the drippings in the skillet. Cover pork chops with apple slices and sprinkle with sugar. Stir the flour into the fat in the skillet until smooth. Whisk in the water and vinegar. Simmer over medium-high heat, stirring constantly, until thick. Add raisins and pour over the pork chops. Cover the baking dish with a lid or aluminum foil. Bake for 1 hour in the preheated oven. Remove the aluminum foil for the last 20 minutes of cooking."
        let rec7 = Recipe(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        rec7.name = "Empty Wallet Casserole"
        rec7.instructions = "Preheat the oven to 350 degrees F (175 degrees C). Crumble the ground beef into a large skillet over medium heat. Season with salt, pepper, cumin, garlic, poultry seasoning, and thyme. Cook, stirring to crumble, until evenly browned. Drain, and transfer to a 9x13 inch baking dish, or large casserole dish. Arrange 2 layers of sliced potato over the ground beef, seasoning each layer with salt and pepper. Melt butter in the skillet over medium heat, and saute the onions and mushrooms until tender. Spread over the top of the potatoes. Stir just enough water into the soup to make it pourable, and spoon over the top of the casserole, making sure to spread out evenly. Scatter the cracker crumbs over the top, and sprinkle with paprika. Cover the dish with aluminum foil. Bake for about 1 hour in the preheated oven, until the potatoes are soft. Remove the aluminum foil, and return to the oven to brown the top, about 10 minutes."
        let rec8 = Recipe(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        rec8.name = "Good Old Fashioned Pancakes"
        rec8.instructions = "In a large bowl, sift together the flour, baking powder, salt and sugar. Make a well in the center and pour in the milk, egg and melted butter; mix until smooth. Heat a lightly oiled griddle or frying pan over medium high heat. Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake. Brown on both sides and serve hot."
        let rec9 = Recipe(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        rec9.name = "Broiled Tilapia Parmesan"
        rec9.instructions = "Preheat your oven's broiler. Grease a broiling pan or line pan with aluminum foil. In a small bowl, mix together the Parmesan cheese, butter, mayonnaise and lemon juice. Season with dried basil, pepper, onion powder and celery salt. Mix well and set aside. Arrange fillets in a single layer on the prepared pan. Broil a few inches from the heat for 2 to 3 minutes. Flip the fillets over and broil for a couple more minutes. Remove the fillets from the oven and cover them with the Parmesan cheese mixture on the top side. Broil for 2 more minutes or until the topping is browned and fish flakes easily with a fork. Be careful not to over cook the fish."
        let rec10 = Recipe(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        rec10.name = "Sloppy Joes II"
        rec10.instructions = "In a medium skillet over medium heat, brown the ground beef, onion, and green pepper; drain off liquids. Stir in the garlic powder, mustard, ketchup, and brown sugar; mix thoroughly. Reduce heat, and simmer for 30 minutes. Season with salt and pepper."

        tmpRecipes = [rec1, rec2, rec3, rec4, rec5, rec6, rec7, rec8, rec9, rec10]
        
        return tmpRecipes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load data from db
        let fetchRequest = NSFetchRequest(entityName: "Recipe")
        do {
            let results = try self.managedObjectContext!.executeFetchRequest(fetchRequest)
            self.recipes = results as! [Recipe]
            //load some recipes if db is empty
            if recipes.count == 0 {
                self.recipes = self.loadDummyRecipes()
                //save recipes into db
                do {
                    try managedObjectContext!.save()
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        
        //init searchbar and add it to the navigation bar
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        if let splitViewController = splitViewController {
            let controllers = splitViewController.viewControllers
            recipeDetailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? RecipeDetailViewController
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        self.filteredRecipes = self.recipes.filter { recipe in
            return recipe.name!.lowercaseString.containsString(searchText.lowercaseString)
        }
        self.tableView.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.filterContentForSearchText(searchController.searchBar.text!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredRecipes.count
        }
        return recipes.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let recipe: Recipe
                if searchController.active && searchController.searchBar.text != "" {
                    recipe = self.filteredRecipes[indexPath.row]
                } else {
                    recipe = self.recipes[indexPath.row]
                }
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! RecipeDetailViewController
                //controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.recipeDetails = recipe
            }
        }

    }
    


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "RecipeTableViewCell"
    
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RecipeTableViewCell

        let recipe:Recipe
        
        if searchController.active && searchController.searchBar.text != "" {
            recipe = self.filteredRecipes[indexPath.row]
        } else {
            recipe = self.recipes[indexPath.row]
        }
        
        cell.recipeName.text = recipe.name
        
        return cell
    }

}
