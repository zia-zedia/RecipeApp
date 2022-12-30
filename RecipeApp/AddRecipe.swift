//
//  AddRecipe.swift
//  RecipeApp
//
//  Created by moh on 29/12/2022.
//

import UIKit

class AddRecipe: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    var user:User? = nil;
    var recipe:Recipe = Recipe(recipeId:String(UUID().uuidString.split(separator: "-")[0]),image: "default.jpeg", recipeName: "Recipe Name", category: "", servingSize: "Per 100g", calories: 0, protein: 0, carb: 0, fat: 0, ingredients: "", instructions: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let background = UIImageView(image: UIImage(named:"background3.png"));
        background.contentMode = .scaleAspectFill;
        tableView.backgroundView = background;
        
        
    }
    
    
    
    var recipeImage: UIImageView? = nil;
    var categoryBtn: UIButton? = nil;
    var submitBtn: UIButton? = nil;
    var recipeName: UITextField? = nil;
    var calories: UITextField? = nil;
    var fats: UITextField? = nil;
    var carb: UITextField? = nil;
    var protein: UITextField? = nil;
    var ingredients: UITextView? = nil;
    var instructions: UITextView? = nil;
    var imagePicker = UIImagePickerController()
    // MARK: - Table view data source
    func saveImage(image: UIImage, name:String) {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return
        }
        do {
            try data.write(to: directory.appendingPathComponent(name)!)
            recipe.image = name;
            return
        } catch {
            print(error.localizedDescription)
            return
        }
        
    }
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                  imagePicker.delegate = self
                  imagePicker.sourceType = .photoLibrary
                  imagePicker.allowsEditing = false

                  present(imagePicker, animated: true, completion: nil)
          }
    }
    @objc func categorytBtnTapped(sender: UITapGestureRecognizer) {
        guard let userId = user?.userId else{return}
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentDirectory.appendingPathComponent("categories_"+userId).appendingPathExtension("plist")
        let propertyDecoder = PropertyListDecoder()
        guard let retrievedCategories = try? Data(contentsOf: archiveURL),
              let decodedCategories = try? propertyDecoder.decode(Array<Category>.self, from: retrievedCategories)else {
               return;
        }
        for cat in decodedCategories{
            alert.addAction(
                .init(title: cat.categoryName, style: .default) { _ in
                    self.categoryBtn?.setTitle(cat.categoryName, for: .normal)
                    self.recipe.category = cat.categoryId;
                }
            )
        }
        

        present(alert, animated: true)
    }
    @objc func submitBtnTapped(sender: UITapGestureRecognizer) {
        recipe.recipeName = recipeName?.text ?? "Recipe Name"
        recipe.calories = Int(calories?.text ?? "") ?? 0
        recipe.carb = Int(carb?.text ?? "") ?? 0
        recipe.protein = Int(protein?.text ?? "") ?? 0
        recipe.fat = Int(fats?.text ?? "") ?? 0
        recipe.instructions = instructions?.text ?? ""
        recipe.ingredients = ingredients?.text ?? ""
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentDirectory.appendingPathComponent("Recipe_"+recipe.category).appendingPathExtension("plist")
        let propertyDecoder = PropertyListDecoder()
        guard let retrievedRecipes = try? Data(contentsOf: archiveURL),
              var decodedRecipes = try? propertyDecoder.decode(Array<Recipe>.self, from: retrievedRecipes)else {
               return;
        }
        decodedRecipes.append(recipe)
        let propertyListEncoder = PropertyListEncoder()
        let encodedData = try? propertyListEncoder.encode(decodedRecipes)
        try? encodedData?.write(to: archiveURL, options: .noFileProtection)
        
        tabBarController?.selectedIndex = 0
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          picker.dismiss(animated: true, completion: nil)
          if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
              saveImage(image: image, name: String(UUID().uuidString.split(separator: "-")[0])+".png")
              recipeImage?.image = image
          }

      }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddRecipeImageCell", for: indexPath) as! AddRecipeImageCell
            
            recipeImage = cell.recipeImage
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
            recipeImage?.addGestureRecognizer(tapGR)
            recipeImage?.isUserInteractionEnabled = true
            
            return cell
        }else if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddRecipeNameCell", for: indexPath) as! AddRecipeNameCell
            recipeName = cell.recipeName;
            return cell
        }else if(indexPath.row == 2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddRecipeCategoryCell", for: indexPath) as! AddRecipeCategoryCell
            
            categoryBtn = cell.categoryBtn
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.categorytBtnTapped))
            categoryBtn?.addGestureRecognizer(tapGR)
            categoryBtn?.isUserInteractionEnabled = true
            
            return cell
        }else if(indexPath.row == 3){
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddRecipeNutritionCell", for: indexPath) as! AddRecipeNutritionCell
            calories = cell.caloriesInput
            fats = cell.fatsInput
            carb = cell.carbInput
            protein = cell.proteinInput
            return cell
        }else if(indexPath.row == 4){
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddRecipeIngredientsCell", for: indexPath) as! AddRecipeIngredientsCell
            ingredients = cell.ingredientsInput
            return cell
        }else if(indexPath.row == 5){
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddRecipeInstructionsCell", for: indexPath) as! AddRecipeInstructionsCell
            instructions = cell.instructionsInput
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "addRecipeSubmitCell", for: indexPath) as! addRecipeSubmitCell
            
            submitBtn = cell.submitBtn
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.submitBtnTapped))
            submitBtn?.addGestureRecognizer(tapGR)
            submitBtn?.isUserInteractionEnabled = true
            
            return cell
        }

       
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
