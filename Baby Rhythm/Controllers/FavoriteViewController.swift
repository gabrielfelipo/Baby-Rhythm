//
//  FavoriteViewController.swift
//  Baby Rhythm
//
//  Created by gabrielfelipo on 13/06/22.
//

import Foundation
import AVFoundation
import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var favorite: UILabel!
    @IBOutlet weak var favButton: UIImageView!
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    var favoriteArray = [String]()
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        
        favoriteArray = Favoritos.shared.favArray
        
        
// TITULO
        favorite.text = "Favoritos".uppercased()
        favorite.font = UIFont(name:"HelveticaNeue-Bold", size: 34.0)
        
        
// COLLECTION VIEW
        favoriteCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        favoriteCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 8).isActive = true
        favoriteCollectionView.rightAnchor.constraint(equalTo: self.view.leftAnchor, constant: UIScreen.main.bounds.width-8).isActive = true
        favoriteCollectionView.topAnchor.constraint(equalTo: favButton.bottomAnchor, constant: 8).isActive = true
        favoriteCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return favoriteArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let music = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCollectionCell", for: indexPath) as! FavoriteCollectionViewCell
        
        let musica = favoriteArray[indexPath.row]
        
        music.name.text = musica
        music.image.image = UIImage(named: musica)
        
        music.playButton.tag = indexPath.item
        music.playButton.addTarget(self, action: #selector(self.play), for: .touchUpInside)
        
        music.arrumalayout()
        
        return music
    }
    @IBAction func play(_ sender: UIButton) {
        if let player = player, player.isPlaying {
            player.stop()
        }
        
        else {
            let urlString = Bundle.main.path(forResource: favoriteArray[sender.tag], ofType: "mp3")
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else {
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else {
                    return
                }
                
                player.play()
            }
            catch {
                print("deu pau")
            }
        }
    }
}
