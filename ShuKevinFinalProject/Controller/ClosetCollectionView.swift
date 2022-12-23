//
//  ClosetCollectionView.swift
//  ShuKevinFinalProject
//
//  Created by Kevin Shu on 11/21/22.
//

import UIKit

class ClosetCollectionView: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    private let user = User.sharedInstance
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImages()
        self.collectionView.reloadData()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.clothesModel?.closet.count ?? 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ClosetCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClosetCell", for: indexPath) as! ClosetCollectionViewCell
        
        
//        //create a clothes array
//        var clothesArr: [Garment] = []
//
//
//        //shouldn't lead to a problem since if the clothesModel is nil, then there are no values in the section
//        if let clothesModel = user.clothesModel{
//            clothesArr = [Garment](clothesModel.closet.values)
//
//        }
       
        //just need to set cell image view
        
        let image = user.clothesModel?.closet[indexPath.row].image
        cell.imageView.image = image
        cell.nameLabel.text = user.clothesModel?.closet[indexPath.row].name
        
        
        
        return cell
    }
    
    func loadImages(){

        //load and sort the images in a separate thread
        user.clothesModel?.load{images in

            DispatchQueue.main.async{

                self.collectionView.reloadData()
            }
        }


    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if let addVC = segue.destination as? AddGarmentViewController{
        
            addVC.completionHandler = {(image: UIImage?, name: String?, type: String?, dressCode: String?) in
                
                //this runs when the modal view is closed.
                if let image = image, let name = name, let type = type, let dressCode = dressCode {
                    
                    //we're just making a new garment here to be added to the user's model
                    
                    let newGarment = Garment(userId: self.user.id, image: image, name: name, type: type, dressCode: dressCode)
                    
                    //if the user is not logged in, then their clothesModel will be nil, and they shouldn't be able to add a garment
                    self.user.clothesModel?.addGarment(garment: newGarment)
                    
                }
                
                //reload our collection view with our new added garment
                self.collectionView.reloadData()
                
                //dismiss our addGarment view
                self.dismiss(animated: true, completion: nil)

            }
            
        }
        
        
    }
    
    
    @IBAction func logOutDidPressed(_ sender: UIBarButtonItem) {
        user.logOut()
        self.performSegue(withIdentifier: "ClosetLogOut", sender: nil)
    }
    
    
}
