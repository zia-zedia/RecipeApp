//
//  recipeList.swift
//  RecipeApp
//
//  Created by moh on 24/12/2022.
//

import UIKit

class recipeList: UITableViewController {
    var recipes: [Recipe] = [];
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let background = UIImageView(image: UIImage(named:"background2.png"));
        background.contentMode = .scaleAspectFill;
        tableView.backgroundView = background;
        getRecipes()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    func getRecipes(){
        self.recipes = [Recipe(image: "tacos.jpg", recipeName: "Tacos", category: "Mexican", calories: 182, protein: 9, carb: 45, fat: 20, ingredients: "1lb ground beef \n 1 Tablespoon chilli powder \n 3/4 cup salt \n 1/2 cup tomato sauce", instructions: "put the meat in the oven, wait for 50 minutes then open the beef put inside tomato eat tomato then put tablespoon chilli powder inside tomato and put inside beef BOM tacos"),Recipe(image: "tacos.jpg", recipeName: "Tacos", category: "Mexican", calories: 182, protein: 9, carb: 45, fat: 20, ingredients: "1lb ground beef \n 1 Tablespoon chilli powder \n 3/4 cup salt \n 1/2 cup tomato sauce", instructions: "put the meat in the oven, wait for 50 minutes then open the beef put inside tomato eat tomato then put tablespoon chilli powder inside tomato and put inside beef BOM tacos"),Recipe(image: "tacos.jpg", recipeName: "Tacos", category: "Mexican", calories: 182, protein: 9, carb: 45, fat: 20, ingredients: "1lb ground beef \n 1 Tablespoon chilli powder \n 3/4 cup salt \n 1/2 cup tomato sauce", instructions: "put the meat in the oven, wait for 50 minutes then open the beef put inside tomato eat tomato then put tablespoon chilli powder inside tomato and put inside beef BOM tacos"),Recipe(image: "tacos.jpg", recipeName: "Tacos", category: "Mexican", calories: 182, protein: 9, carb: 45, fat: 20, ingredients: "1lb ground beef \n 1 Tablespoon chilli powder \n 3/4 cup salt \n 1/2 cup tomato sauce", instructions: "put the meat in the oven, wait for 50 minutes then open the beef put inside tomato eat tomato then put tablespoon chilli powder inside tomato and put inside beef BOM tacos"),Recipe(image: "tacos.jpg", recipeName: "Tacos", category: "Mexican", calories: 182, protein: 9, carb: 45, fat: 20, ingredients: "1lb ground beef \n 1 Tablespoon chilli powder \n 3/4 cup salt \n 1/2 cup tomato sauce", instructions: "put the meat in the oven, wait for 50 minutes then open the beef put inside tomato eat tomato then put tablespoon chilli powder inside tomato and put inside beef BOM tacos")]
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeCell else { return UITableViewCell() }
        
        
        cell.recipeName.text = recipes[indexPath.row].recipeName
        cell.recipeImage.image = UIImage(named:recipes[indexPath.row].image)
        cell.nutritionInfo.text = String(recipes[indexPath.row].calories)+" Calories"
        
        // Configure the cell...

        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
