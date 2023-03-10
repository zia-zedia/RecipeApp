//
//  EditRecipe.swift
//  RecipeApp
//
//  Created by moh on 29/12/2022.
//

import UIKit

class EditRecipe: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    var user:User? = nil;
    var recipe:Recipe? = nil;
    var cat:Category? = nil;
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
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
    
    var recipeImage: UIImageView? = nil;
    var categoryBtn: UIButton? = nil;
    var submitBtn: UIButton? = nil;
    var deleteBtn: UIButton? = nil;
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
            recipe!.image = name;
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
    @objc func deleteBtnTapped(sender: UITapGestureRecognizer) {
        guard let userId = user?.userId else{return}
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentDirectory.appendingPathComponent("Recipe_"+recipe!.category+"_"+userId).appendingPathExtension("plist")
        let propertyDecoder = PropertyListDecoder()
        guard let retrievedRecipes = try? Data(contentsOf: archiveURL),
              var decodedRecipes = try? propertyDecoder.decode(Array<Recipe>.self, from: retrievedRecipes)else {
               return;
        }
        decodedRecipes = decodedRecipes.filter{$0.recipeId != recipe!.recipeId}
        
        let propertyListEncoder = PropertyListEncoder()
        let encodedData = try? propertyListEncoder.encode(decodedRecipes)
        try? encodedData?.write(to: archiveURL, options: .noFileProtection)
        
        _ = navigationController?.popViewController(animated: true)
    }
    @objc func submitBtnTapped(sender: UITapGestureRecognizer) {
        guard let userId = user?.userId else{return}
        recipe!.recipeName = recipeName?.text ?? "Recipe Name"
        recipe!.calories = Int(calories?.text ?? "") ?? 0
        recipe!.carb = Int(carb?.text ?? "") ?? 0
        recipe!.protein = Int(protein?.text ?? "") ?? 0
        recipe!.fat = Int(fats?.text ?? "") ?? 0
        recipe!.instructions = instructions?.text ?? ""
        recipe!.ingredients = ingredients?.text ?? ""
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentDirectory.appendingPathComponent("Recipe_"+recipe!.category+"_"+userId).appendingPathExtension("plist")
        let propertyDecoder = PropertyListDecoder()
        guard let retrievedRecipes = try? Data(contentsOf: archiveURL),
              var decodedRecipes = try? propertyDecoder.decode(Array<Recipe>.self, from: retrievedRecipes)else {
               return;
        }
        for a in 0...decodedRecipes.count-1{
            if(decodedRecipes[a].recipeId == recipe?.recipeId){
                decodedRecipes[a] = recipe!
            }
            
        }
        
        let propertyListEncoder = PropertyListEncoder()
        let encodedData = try? propertyListEncoder.encode(decodedRecipes)
        try? encodedData?.write(to: archiveURL, options: .noFileProtection)
        
        _ = navigationController?.popViewController(animated: true)
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
        return 6
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditRecipeImageCell", for: indexPath) as! EditRecipeImageCell
            cell.recipeImage.image = getSavedImage(named: recipe!.image)
            recipeImage = cell.recipeImage
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
            recipeImage?.addGestureRecognizer(tapGR)
            recipeImage?.isUserInteractionEnabled = true
            
            deleteBtn = cell.deleteBtn
            let tapGR2 = UITapGestureRecognizer(target: self, action: #selector(self.deleteBtnTapped))
               deleteBtn?.addGestureRecognizer(tapGR2)
                deleteBtn?.isUserInteractionEnabled = true
            
            return cell
        }else if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditRecipeNameCell", for: indexPath) as! EditRecipeNameCell
            cell.recipeName.text = recipe!.recipeName
            recipeName = cell.recipeName;
            return cell
        }else if(indexPath.row == 2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditRecipeNutritionCell", for: indexPath) as! EditRecipeNutritionCell
            cell.caloriesInput.text = String(recipe!.calories)
            cell.fatsInput.text = String(recipe!.fat)
            cell.carbInput.text = String(recipe!.carb)
            cell.proteinInput.text = String(recipe!.protein)
            
            calories = cell.caloriesInput
            fats = cell.fatsInput
            carb = cell.carbInput
            protein = cell.proteinInput
            return cell
        }else if(indexPath.row == 3){
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditRecipeingredientsCell", for: indexPath) as! EditRecipeingredientsCell
            cell.ingredientsInput.text = recipe!.ingredients
            ingredients = cell.ingredientsInput
            return cell
        }else if(indexPath.row == 4){
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditRecipeInstructionsCell", for: indexPath) as! EditRecipeInstructionsCell
            cell.instructionsInput.text = recipe!.instructions
            instructions = cell.instructionsInput
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditRecipeSubmitCell", for: indexPath) as! EditRecipeSubmitCell
            
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
