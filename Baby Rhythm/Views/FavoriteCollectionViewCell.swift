//
//  FavoriteCollectionViewCell.swift
//  Baby Rhythm
//
//  Created by gabrielfelipo on 13/06/22.
//

import Foundation

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var heart: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    func arrumalayout() {
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        image.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        
        heart.translatesAutoresizingMaskIntoConstraints = false
        
        heart.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        heart.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        heart.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
    }
}
