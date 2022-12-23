//
//  Outfit.swift
//  ShuKevinFinalProject
//
//  Created by Kevin Shu on 11/21/22.
//

import UIKit
import FirebaseFirestore

//describing what an outfit would consist of.
class Outfit{
    
    let id: String
    
    let userId: String
    
    let top: Garment?
    
    let bottom: Garment?
    
    let shoe: Garment?
    
    let outerwear: Garment?
    
    let date: Date
    
    
    init(userId: String, top: Garment?, bottom: Garment?, shoe: Garment?, outerwear: Garment?){
        self.userId = userId
        self.id = Firestore.firestore().collection("outfits").document().documentID
        self.top = top
        self.bottom = bottom
        self.shoe = shoe
        self.outerwear = outerwear
        self.date = Date.now
    }
    
    init(userId: String, top: Garment?, bottom: Garment?, shoe: Garment?, outerwear: Garment?, date: Date){
        self.userId = userId
        self.id = Firestore.firestore().collection("outfits").document().documentID
        self.top = top
        self.bottom = bottom
        self.shoe = shoe
        self.outerwear = outerwear
        self.date = date
        
    }
    
    
    
}

// Loaded from firebase
//let allGarments = [Garment]()
