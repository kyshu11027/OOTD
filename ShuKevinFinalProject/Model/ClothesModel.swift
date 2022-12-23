//
//  ClothesModel.swift
//  ShuKevinFinalProject
//
//  Created by Kevin Shu on 11/21/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class ClothesModel{
    let garmentCollection = Firestore.firestore().collection("garments")
    let outfitCollection = Firestore.firestore().collection("outfits")
    let storageRef = Storage.storage().reference()
    
    //use this when saving and reading dates
    let formatter = DateFormatter()
    
    let userId: String
    
    //garmentId -> Garment
    var closet: [Garment]
    
    var outfits: [Outfit]
    init(userId: String){
        
        //TODO: HOW DO WE GET A USERID FROM LOGIN?
        self.userId = userId
        closet = []
        outfits = []
        //load()
    }
    
    //we need this function to get only the garments of a specified type
    func getType(type: GarmentType) -> [Garment]{
        var types: [Garment] = []
        
        
        for garment in closet{
            
            
            if garment.type == type{
                types.append(garment)
                
            }
            
        }
        
        return types
        
    }
    
    
    
    //read in the user's data based on their userId
    func load(onSuccess: @escaping ([Garment]) -> Void){
        
        //load in our garments based on userId
        //first we need to get our documents by querying by field
        let garmentQuery = garmentCollection.whereField("userId", isEqualTo: self.userId)
        
        //get our documents
        garmentQuery.getDocuments(){(querySnapshot, error) in
            
            //no error has occurred
            if error == nil{
                
                
                //iterate through our documents
                for document in querySnapshot!.documents{
                    let dictionary = document.data()
                    
                    let id: String = dictionary["id"] as! String
                    let userId: String = dictionary["userId"] as! String
                    let name: String = dictionary["name"] as! String
                    let type: String = dictionary["type"] as! String
                    let dressCode: String = dictionary["dressCode"] as! String
                    
                    
                    
                    //load in our stored image from Storage
                    // Create a reference to the file you want to download
                    let reference = self.storageRef.child("\(id).jpeg")

                    // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes) maxSize: 1 * 1024 * 1024
                    reference.getData(maxSize: 1 * 2048 * 2048) { (data, error) in
                      
                        //since we've loaded in our image, now we can build our garment and add it to the model finally
                        if error == nil{
                            
                            //print("in here")
                            let image = UIImage(data: data!)
                            
                            let newGarment = Garment(userId: userId, id: id, image: image!, name: name, type: type, dressCode: dressCode)
                            
                            self.closet.append(newGarment)
                            
                            //no need to save anything here
                            onSuccess(self.closet)
                            
                        }
                        else{
                            print("Error loading in image \(String(describing: error))")
                        }
                    }
                    
                }
                //onSuccess(self.closet)
                
            }
            else{
                print("Error reading garment data")
            }
            
            
        }
        
    }
    
    func getGarment(id: String) -> Garment?{
        
        for garment in closet{
            if garment.id == id{
                
                return garment
            }
            
            
        }
        
        print("hello")
        return nil
    }
    
    
    //separate query for outfit information
    func loadOutfits(onSuccess: @escaping ([Outfit]) -> Void){
        
        //make our query like in the garment query
        let outfitQuery = outfitCollection.whereField("userId", isEqualTo: self.userId)
        
        //get our documents
        outfitQuery.getDocuments(){(querySnapshot, error) in
            
            //no error has occurred
            if error == nil{
                
                for document in querySnapshot!.documents{
                    let dictionary = document.data()
                    
                    let userId: String = dictionary["userId"] as! String
                    
                    let top: Garment? = self.getGarment(id: dictionary["top"] as! String)
                    
                    let bottom: Garment? = self.getGarment(id: dictionary["bottom"] as! String)
                    
                    let shoe: Garment? = self.getGarment(id: dictionary["shoe"] as! String)
                    
                    let outerwear: Garment? = self.getGarment(id: dictionary["outerwear"] as! String)
                    
                    let date = self.formatter.date(from: dictionary["date"] as! String) ?? Date.now
                    
                    let newOutfit: Outfit = Outfit(userId: userId, top: top, bottom: bottom, shoe: shoe, outerwear: outerwear, date: date)
                    
                    
                    self.outfits.append(newOutfit)
                    
                    
                }
                
                //appended all outfits to list at this point
                onSuccess(self.outfits)
            }
            
            else{
                print("Error reading outfit data")
            }
            
        }
        
        
        
        
    }
    

    
    
    
    func addGarment(garment: Garment){
        
        closet.append(garment)
        
        //making all these variables to write to firestore. image not included
        let userId: String = garment.userId
        let id: String = garment.id
        let name: String = garment.name
        let type: String = garment.type.rawValue
        let dressCode: String = garment.dressCode.rawValue
    
        
        
        //save the newly added garment here to firestore
        
        garmentCollection.document(id).setData([
            "userId": userId,
            "id": id,
            "name": name,
            "type": type,
            "dressCode": dressCode
        ])
        
        
        //save image to Storage using the document's id as the name
        
        //create data
        let data = garment.image.jpegData(compressionQuality: 0.7)
        
        //set new reference using image id as the name
        let newRef = storageRef.child("\(id).jpeg")
        
        
        //this should save image
        if let data = data{
            newRef.putData(data, metadata: nil) { (metadata, error) in
                if error != nil{
                    print("Error saving image \(String(describing: error))")
                }
                
            }
        }
        
        
    }
    
    //function to add outfits to the model
    func addOutfit(outfit: Outfit){
        outfits.append(outfit)
        
        //just need to save the id's of the garments
        let userId: String = outfit.userId
        let top: String = outfit.top?.id ?? ""
        let bottom: String = outfit.bottom?.id ?? ""
        let shoe: String = outfit.shoe?.id ?? ""
        let outerwear: String = outfit.outerwear?.id ?? ""
        let date: String = self.formatter.string(from: outfit.date)
        
        outfitCollection.addDocument(data: [
            "userId": userId,
            "top": top,
            "bottom": bottom,
            "shoe": shoe,
            "outerwear": outerwear,
            "date": date
        ])
        
        
        
        
        
        
    }
    
    
}
