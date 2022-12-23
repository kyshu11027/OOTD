//
//  BottomsTableViewController.swift
//  ShuKevinFinalProject
//
//  Created by Kevin Shu on 11/25/22.
//

import UIKit

class BottomsTableViewController: UITableViewController{
    
    private let user = User.sharedInstance
    private let bottoms: [Garment]? = User.sharedInstance.clothesModel?.getType(type: .Bottom)
    
    typealias bottomCompletionHandler = (Garment?) -> Void
    
    var completionHandler: bottomCompletionHandler?
    
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
        return bottoms?.count ?? 0
    }
    
    //define our tableViewCells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BottomTableCell", for: indexPath) as! GarmentTableViewCell
        
        if let garment = bottoms?[indexPath.row]{

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
        let garment = bottoms?[indexPath.row]
        
        if let completionHandler = completionHandler {
            completionHandler(garment)
        }
        
    }
    
}
