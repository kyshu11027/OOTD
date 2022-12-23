//
//  ShoesTableViewController.swift
//  ShuKevinFinalProject
//
//  Created by Kevin Shu on 11/25/22.
//

import UIKit

class ShoesTableViewController: UITableViewController{
    
    
    private let user = User.sharedInstance
    private let shoes: [Garment]? = User.sharedInstance.clothesModel?.getType(type: .Shoe)
    
    typealias shoeCompletionHandler = (Garment?) -> Void
    
    var completionHandler: shoeCompletionHandler?
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // only one section since we're making separate tableviews for each type
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoes?.count ?? 0
    }
    
    //define our tableViewCells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoeTableCell", for: indexPath) as! GarmentTableViewCell
        
        if let garment = shoes?[indexPath.row]{

            cell.nameLabel.text = garment.name

            cell.garmentImageView.image = garment.image

            return cell
            
            
        }
        else{
            //no flashcards available, so we handle that case
            var content = cell.defaultContentConfiguration()
            content.text = "No bottoms"
            content.secondaryText = ""
            
            cell.contentConfiguration = content
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
            
        //guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let garment = shoes?[indexPath.row]
        
        if let completionHandler = completionHandler {
            completionHandler(garment)
        }
        
    }
}
