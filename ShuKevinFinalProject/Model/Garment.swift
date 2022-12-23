//
//  Garment.swift
//  ShuKevinFinalProject
//
//  Created by Kevin Shu on 11/21/22.
//

import UIKit
import FirebaseFirestore

//we need to distinguish between different garments
enum GarmentType: String{
    case Top = "top"
    
    case Bottom = "bottom"
    
    case Shoe = "shoe"
    
    case Outerwear = "outerwear"
    
    //this is just an in case of error case
    case None = "none"
    
    
}

enum DressCode: String{
    
    case Formal = "formal"
    case Casual = "casual"
    case InBetween = "in between"
    case None = "none"
    
}


class Garment{
    
    let id: String //this is the garment id which will be used to create outfits
    
    let userId: String
    
    let type: GarmentType
    let name: String
    let image: UIImage
    let dressCode: DressCode
    
    init(userId: String, image: UIImage, name: String, type: String, dressCode: String){
        self.userId = userId
        self.id = Firestore.firestore().collection("garments").document().documentID
        self.image = image
        self.name = name
        
        self.type = GarmentType(rawValue: type) ?? GarmentType.None
        self.dressCode = DressCode(rawValue: dressCode) ?? DressCode.None

    }
    
    init(userId: String, id: String, image: UIImage, name: String, type: String, dressCode: String){
        self.userId = userId
        self.id = id
        self.image = image
        self.name = name
        
        self.type = GarmentType(rawValue: type) ?? GarmentType.None
        self.dressCode = DressCode(rawValue: dressCode) ?? DressCode.None

    }
    
    
}
