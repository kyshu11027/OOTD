//
//  OutfitsCollectionViewCell.swift
//  ShuKevinFinalProject
//
//  Created by Kevin Shu on 11/25/22.
//

import Foundation
import UIKit


class OutfitsCollectionViewCell: UICollectionViewCell{
    
    
    @IBOutlet var topImageView: UIImageView!
    
    @IBOutlet var bottomImageView: UIImageView!
    
    @IBOutlet var shoeImageView: UIImageView!
    
    @IBOutlet var outerwearImageView: UIImageView!
    
    override func layoutSubviews() {
        // cell rounded section
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
        // cell shadow section
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.6
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        
    }
    
}
