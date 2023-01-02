//
//  recipeList.swift
//  RecipeApp
//
//  Created by moh on 24/12/2022.
//

import UIKit

class recipeList: UITableViewController {
    var recipes: [Recipe] = [];
    var cat:Category? = nil;
    var user:User? = nil;
    var sortMode = String(UserDefaults.standard.string(forKey: "sortMode") ?? "cal")
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let background = UIImageView(image: UIImage(named:"background2.png"));
        background.contentMode = .scaleAspectFill;
        tableView.backgroundView = background;
        
        guard let categoryName = cat?.categoryName else{return}
        self.title = categoryName
        
        getRecipes("","cal")
    }
    
    @IBOutlet weak var searchBar: UITextField!
    @IBAction func searching(_ sender: Any) {
        guard let searchStr = searchBar.text else {return}
        getRecipes(searchStr.lowercased(),sortMode)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        getRecipes("","cal")
    }
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    @IBAction func sortList(_ sender: Any) {
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )

        alert.addAction(
            .init(title: "Calories", style: .default) { _ in
                self.sortMode = "cal";
                self.getRecipes(self.searchBar.text ?? "",self.sortMode);
            }
        )

        alert.addAction(
            .init(title: "Carbohydrates", style: .default) { _ in
                self.sortMode = "carb";
                self.getRecipes(self.searchBar.text ?? "",self.sortMode);
                
            }
        )
        alert.addAction(
            .init(title: "Fats", style: .default) { _ in
                self.sortMode = "fat";
                self.getRecipes(self.searchBar.text ?? "",self.sortMode);
                
            }
        )
        alert.addAction(
            .init(title: "Protein", style: .default) { _ in
                self.sortMode = "pro";
                self.getRecipes(self.searchBar.text ?? "",self.sortMode);
                
            }
        )

        present(alert, animated: true)
    }
    func getRecipes(_ searchStr:String, _ sortType:String){
        guard let categoryId = cat?.categoryId else{return}
        guard let userId = user?.userId else{return}
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentDirectory.appendingPathComponent("Recipe_"+categoryId+"_"+userId).appendingPathExtension("plist")
        let propertyDecoder = PropertyListDecoder()
        guard let retrievedRecipes = try? Data(contentsOf: archiveURL),
              let decodedRecipes = try? propertyDecoder.decode(Array<Recipe>.self, from: retrievedRecipes)else {
               return;
        }
        if(searchStr == "" && sortType == "cal"){
            self.recipes = decodedRecipes.sorted(by: Recipe.calSort)
        }else if(searchStr == "" && sortType == "carb"){
            
            self.recipes = decodedRecipes.sorted(by: Recipe.carbSort)
            
        }else if(searchStr == "" && sortType == "fat"){
            self.recipes = decodedRecipes.sorted(by: Recipe.fatSort)
        }else if(searchStr == "" && sortType == "pro"){
            self.recipes = decodedRecipes.sorted(by: Recipe.proteinSort)
        }else if(searchStr != "" && sortType == "cal"){
            self.recipes = decodedRecipes.sorted(by: Recipe.calSort)
            
            let filteredRecipes = self.recipes.filter{
                $0.recipeName.lowercased().contains(searchStr)
            }
            
            self.recipes = filteredRecipes
            
        }else if(searchStr != "" && sortType == "carb"){
            self.recipes = decodedRecipes.sorted(by: Recipe.carbSort)
            
            let filteredRecipes = self.recipes.filter{
                $0.recipeName.lowercased().contains(searchStr)
            }
            
            self.recipes = filteredRecipes
            
        }else if(searchStr != "" && sortType == "fat"){
            self.recipes = decodedRecipes.sorted(by: Recipe.fatSort)
            
            let filteredRecipes = self.recipes.filter{
                $0.recipeName.lowercased().contains(searchStr)
            }
            
            self.recipes = filteredRecipes
            
        }else if(searchStr != "" && sortType == "pro"){
            self.recipes = decodedRecipes.sorted(by: Recipe.proteinSort)
            
            let filteredRecipes = self.recipes.filter{
                $0.recipeName.lowercased().contains(searchStr)
            }
            
            self.recipes = filteredRecipes
            
        }
        tableView.reloadData()
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeDetails" {
            if let destinationVC = segue.destination as? RecipeDetails {
                destinationVC.recipe = recipes[(sender as AnyObject).tag];
            }
        }else if segue.identifier == "EditRecipe" {
            
            if let destinationVC = segue.destination as? EditRecipe {
                destinationVC.recipe = recipes[(sender as AnyObject).tag];
                destinationVC.cat = cat;
                destinationVC.user = user;
            }
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeCell else { return UITableViewCell() }
        
        cell.tag = indexPath.row
        cell.editBtn.tag = indexPath.row
        cell.recipeName.text = recipes[indexPath.row].recipeName
        cell.recipeImage.image = getSavedImage(named:recipes[indexPath.row].image)
        if(sortMode == "cal"){
            cell.nutritionInfo.text = String(recipes[indexPath.row].calories)+" Calories"
        }else if(sortMode == "carb"){
            cell.nutritionInfo.text = String(recipes[indexPath.row].carb)+"g Carbohydrate"
        }else if(sortMode == "fat"){
            cell.nutritionInfo.text = String(recipes[indexPath.row].fat)+"g Fat"
        }else if(sortMode == "pro"){
            cell.nutritionInfo.text = String(recipes[indexPath.row].protein)+"g Protein"
        }

        
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
