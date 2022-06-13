//
//  PlaylistCollectionViewCell.swift
//  Baby Rhythm
//
//  Created by gabrielfelipo on 18/05/22.
//

import Foundation

import UIKit

class PlaylistCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var heart: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    func arrumalayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        
        heart.translatesAutoresizingMaskIntoConstraints = false
        
        heart.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        heart.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        heart.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
    }
}
