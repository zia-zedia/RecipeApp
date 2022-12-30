//
//  HomePageTableViewController.swift
//  RecipeApp
//
//  Created by moh on 23/12/2022.
//

import UIKit

class HomePageTableViewController: UITableViewController {
    var categories: [Category] = [];
    var user:User? = nil;
    var sortMode = "ABC"
    @IBOutlet weak var sortBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let background = UIImageView(image: UIImage(named:"background.png"));
        background.contentMode = .scaleAspectFill;
        tableView.backgroundView = background;
        
        
        
        
        getCategories("","ABC");
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        getCategories("","ABC");
    }
    
    @IBAction func sortList(_ sender: Any) {
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )

        alert.addAction(
            .init(title: "Ascending", style: .default) { _ in
                self.getCategories(self.searchBar.text ?? "","ABC");
                self.sortMode = "ABC"
            }
        )

        alert.addAction(
            .init(title: "Descending", style: .default) { _ in
                self.getCategories(self.searchBar.text ?? "","ZYX");
                self.sortMode = "ZYX"
            }
        )

        present(alert, animated: true)
    }
    @IBOutlet weak var searchBar: UITextField!
    @IBAction func searching(_ sender: Any) {
        guard let searchStr = searchBar.text else {return}
        
        getCategories(searchStr.lowercased(),sortMode);
    }
    
    func getCategories(_ searchStr:String, _ sortType:String){
        guard let userId = user?.userId else{return}
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentDirectory.appendingPathComponent("categories_"+userId).appendingPathExtension("plist")
        let propertyDecoder = PropertyListDecoder()
        guard let retrievedCategories = try? Data(contentsOf: archiveURL),
              let decodedCategories = try? propertyDecoder.decode(Array<Category>.self, from: retrievedCategories)else {
               return;
        }
        
        if(searchStr == "" && sortType == "ABC"){
            self.categories = decodedCategories.sorted(by: <)
        }else if(searchStr == "" && sortType == "ZYX"){
            self.categories = decodedCategories.sorted(by: >)
        }else if(searchStr != "" && sortType == "ABC"){
            self.categories = decodedCategories.sorted(by: <)
            let filteredCategories = self.categories.filter{
                $0.categoryName.lowercased().contains(searchStr)
            }
            self.categories = filteredCategories
            
        }else if(searchStr != "" && sortType == "ZYX"){
            self.categories = decodedCategories.sorted(by: >)
            let filteredCategories = self.categories.filter{
                $0.categoryName.lowercased().contains(searchStr)
            }
            self.categories = filteredCategories
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
        return categories.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditCategory" {
            if let destinationVC = segue.destination as? EditCategory {
                destinationVC.user = user;
                destinationVC.cat = categories[(sender as AnyObject).tag];
            }
        }else if segue.identifier == "recipeList" {
            if let destinationVC = segue.destination as? recipeList {
                destinationVC.cat = categories[(sender as AnyObject).tag];
                destinationVC.user = user;
                
            }
        }else if segue.identifier == "AddCategory"{
            if let destinationVC = segue.destination as? AddCategory {
                destinationVC.user = user;
                
            }
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? categoryCell else { return UITableViewCell() }
            
        cell.editBtn?.tag = indexPath.row;
        cell.tag = indexPath.row;
        cell.categoryLbl.text = categories[indexPath.row].categoryName

        
        // Configure the cell...

        return cell
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
