//
//  OutfitsCollectionView.swift
//  ShuKevinFinalProject
//
//  Created by Kevin Shu on 11/25/22.
//

import UIKit

class OutfitsCollectionView: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    private let user = User.sharedInstance
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        loadOutfits()
        self.collectionView.reloadData()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.clothesModel?.outfits.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OutfitsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OutfitCell", for: indexPath) as! OutfitsCollectionViewCell
        
        let topImage = user.clothesModel?.outfits[indexPath.row].top?.image
        let bottomImage = user.clothesModel?.outfits[indexPath.row].bottom?.image
        let shoeImage = user.clothesModel?.outfits[indexPath.row].shoe?.image
        let outerwearImage = user.clothesModel?.outfits[indexPath.row].outerwear?.image
        
        cell.topImageView.image = topImage
        cell.bottomImageView.image = bottomImage
        cell.shoeImageView.image = shoeImage
        cell.outerwearImageView.image = outerwearImage
        
        return cell
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let addVC = segue.destination as? AddOutfitViewController{
            addVC.completionHandler = {(top: Garment?, bottom: Garment?, shoe: Garment?, outerwear: Garment?) in
                
                //this runs when the modal view is closed.
                if let top = top, let bottom = bottom, let shoe = shoe, let outerwear = outerwear {
                    
                    //we're just making a new outfit here to be added to the user's model
                    
                    let newOutfit = Outfit(userId: self.user.id, top: top, bottom: bottom, shoe: shoe, outerwear: outerwear)
                    
                    //if the user is not logged in, then their clothesModel will be nil, and they shouldn't be able to add a garment
                    self.user.clothesModel?.addOutfit(outfit: newOutfit)
                    
                }
                
                //reload our collection view with our new added garment
                self.collectionView.reloadData()
                
                //dismiss our addOutfit view
                self.dismiss(animated: true, completion: nil)
                
                
                
            }
            
            
        }
    }
    
    func loadOutfits(){

        //load and sort the images in a separate thread
        user.clothesModel?.loadOutfits{images in

            DispatchQueue.main.async{

                self.collectionView.reloadData()
            }
        }


    }
    
    
    
    @IBAction func logOutDidPressed(_ sender: UIBarButtonItem) {
        user.logOut()
        self.performSegue(withIdentifier: "OutfitLogOut", sender: nil)
    }
    
    
}
