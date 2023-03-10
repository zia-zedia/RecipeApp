//
//  RecipeDetails.swift
//  RecipeApp
//
//  Created by moh on 26/12/2022.
//

import UIKit

class RecipeDetails: UITableViewController {
    var recipe: Recipe? = nil;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let background = UIImageView(image: UIImage(named:"background3.png"));
        background.contentMode = .scaleAspectFill;
        tableView.backgroundView = background;
        self.title = recipe?.recipeName
        
    }

    // MARK: - Table view data source
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDetailsImageCell", for: indexPath) as! RecipeDetailsImageCell
            if let recipeImage = recipe?.image{
                cell.recipeImage.image = getSavedImage(named:recipeImage)
            }
            
            return cell
        }else if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDetailsNutritionCell", for: indexPath) as! RecipeDetailsNutritionCell
            if let calories = recipe?.calories{
                cell.calories.text = String(calories)+" Calories"
            }
            if let fat = recipe?.fat{
                cell.fat.text = String(fat)+"g Fat"
            }
            if let carb = recipe?.carb{
                cell.carb.text = String(carb)+"g Carbohydrates"
            }
            if let protein = recipe?.protein{
                cell.protein.text = String(protein)+"g Protein"
            }
            if let servingSize = recipe?.servingSize{
                cell.servingSize.text = String(servingSize)
            }
            return cell
        }else if(indexPath.row == 2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDetailsIngredientsCell", for: indexPath) as! RecipeDetailsIngredientsCell
            
            cell.ingredients.text = recipe?.ingredients
            cell.ingredients.sizeToFit()
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDetailsInstructionsCell", for: indexPath) as! RecipeDetailsInstructionsCell
            
            cell.instructions.text = recipe?.instructions
            cell.instructions.sizeToFit()
            return cell
        }


        // Configure the cell...

        
    }

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
