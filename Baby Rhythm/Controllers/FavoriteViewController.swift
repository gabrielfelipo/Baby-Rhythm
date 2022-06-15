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
    
    var player: AVAudioPlayer?
    var playingMusic: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // OBSERVER
        NotificationCenter.default.addObserver(self, selector: #selector(doINeedUpdate(_:)), name: Notification.Name("reloadFav"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopMusic(_:)), name: Notification.Name("isPlaying"), object: nil)
        
        // Do any additional setup after loading the view.
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        
        
        
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
    
    @objc func doINeedUpdate(_ notification: Notification) {
        favoriteCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Favoritos.shared.favArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let music = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCollectionCell", for: indexPath) as! FavoriteCollectionViewCell
        
        let musica = Favoritos.shared.favArray[indexPath.row]
        
        music.name.text = musica
        music.image.image = UIImage(named: musica)
        
        music.playButton.tag = indexPath.item
        music.playButton.addTarget(self, action: #selector(self.play), for: .touchUpInside)
        
        music.removeButton.tag = indexPath.item
        music.removeButton.addTarget(self, action: #selector(self.Fav), for: .touchUpInside)
        
        music.arrumalayout()
        
        return music
    }
    
    @objc func stopMusic(_ notification: Notification) {
        player?.stop()
        guard let musicStop = favoriteCollectionView.cellForItem(at: [0,playingMusic ?? 0]) as? FavoriteCollectionViewCell else { return }
        musicStop.name.textColor = UIColor(red: 0.00, green: 0, blue: 0, alpha: 1.00)
    }
    
    @IBAction func play(_ sender: UIButton) {
        guard let musicPlaying = favoriteCollectionView.cellForItem(at: [0,sender.tag]) as? FavoriteCollectionViewCell else { return }
        if let player = player, player.isPlaying {
            player.stop()
            let lastPlaying = favoriteCollectionView.cellForItem(at: [0,playingMusic ?? 0]) as? FavoriteCollectionViewCell
            lastPlaying?.name.textColor = UIColor(red: 0.00, green: 0, blue: 0, alpha: 1.00)
            if musicPlaying != lastPlaying {
                play(sender)
            }
        }
        
        else {
            favoriteCollectionView.reloadData()
            let urlString = Bundle.main.path(forResource: Favoritos.shared.favArray[sender.tag], ofType: "mp3")
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
                musicPlaying.name.textColor = UIColor(red: 1.00, green: 0.62, blue: 0.70, alpha: 1.00)
                playingMusic = sender.tag
                
                //SEND TO LIST VIEW CONTROLLER
                NotificationCenter.default.post(name: Notification.Name("isPlayingFav"), object: nil)
            }
            catch {
                print("deu pau")
            }
        }
    }
    
    @IBAction func Fav(_ sender: UIButton) {
        guard let musicPlaying = favoriteCollectionView.cellForItem(at: [0,sender.tag]) as? FavoriteCollectionViewCell else { return }
        let indexFav = Favoritos.shared.favArray.firstIndex(of: musicPlaying.name.text ?? "")
        Favoritos.shared.favArray.remove(at: indexFav ?? 0)
        
    
        //Remove pink collor of label and stop music
        let lastPlaying = favoriteCollectionView.cellForItem(at: [0,playingMusic ?? 0]) as? FavoriteCollectionViewCell
        
        if playingMusic == sender.tag {
            player?.stop()
            lastPlaying?.name.textColor = UIColor(red: 0.00, green: 0, blue: 0, alpha: 1.00)
        }
        
        //SEND TO LIST VIEW CONTROLLER
        NotificationCenter.default.post(name: Notification.Name("favRemoved"), object: nil)
        
        favoriteCollectionView.reloadData()
    }
    
}
