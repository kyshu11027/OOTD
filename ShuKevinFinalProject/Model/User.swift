//
//  User.swift
//  ShuKevinFinalProject
//
//  Created by Kevin Shu on 11/24/22.
//

import UIKit


//define our user class and instantiate a singleton

class User{
    
    var id: String
    var email: String
    var clothesModel: ClothesModel?
    
    //this singleton will be used to track user information
    static let sharedInstance = User()
    
    init(){
        email = ""
        id = ""
        clothesModel = nil
    }
    
    //run this function when we log out.
    func logOut(){
        id = ""
        email = ""
        clothesModel = nil
    }
    
    
    //run this whenever we log in or sign up
    func logIn(id: String, email: String){
        self.id = id
        self.email = email
        clothesModel = ClothesModel(userId: self.id)
        
    }
}
