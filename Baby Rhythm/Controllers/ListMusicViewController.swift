//
//  ListMusicViewController.swift
//  Baby Rhythm
//
//  Created by gabrielfelipo on 18/05/22.
//

import Foundation
import AVFoundation
import UIKit

class ListMusicViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var musicCollectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playButton: UIImageView!
    @IBOutlet weak var catTitle: UILabel!
    
    var favoriteArray = Favoritos.shared.favArray
    var playColor: UIColor?
    var player: AVAudioPlayer?
    var image: String?
    var category: Int?
    var playingMusic: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        musicCollectionView.delegate = self
        musicCollectionView.dataSource = self
        
        // OBSERVER
        NotificationCenter.default.addObserver(self, selector: #selector(stopMusic(_:)), name: Notification.Name("isPlayingFav"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeFav(_:)), name: Notification.Name("favRemoved"), object: nil)
        
//  CAPA
        imageView.image = UIImage(named: image ?? "")
        catTitle.text = image?.uppercased()
        catTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 34.0)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.topAnchor,constant: 330).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

//  PLAY
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        playButton.centerYAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        playButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
//  COLLECTION VIEW
        musicCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        musicCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 8).isActive = true
        musicCollectionView.rightAnchor.constraint(equalTo: self.view.leftAnchor, constant: UIScreen.main.bounds.width-8).isActive = true
        musicCollectionView.topAnchor.constraint(equalTo: playButton.bottomAnchor).isActive = true
        musicCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        

        
        
    }
    
    let musicas = [["Crack Baby","I Will"],[],[],[]]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return musicas[category ?? 0].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let music = collectionView.dequeueReusableCell(withReuseIdentifier: "playlistCollectionCell", for: indexPath) as! PlaylistCollectionViewCell
        
        let musica = musicas[category ?? 0][indexPath.row]
        
        music.nome.text = musica
        
        if Favoritos.shared.favArray.contains(music.nome.text ?? "algo") {
            music.heart.image = UIImage(named: "fullPinkHeart")
        }
        
        else {
            music.heart.image = UIImage(named: "PinkHeart")
        }
        music.imageView.image = UIImage(named: musica)
        
        music.playButton.tag = indexPath.item
        music.playButton.addTarget(self, action: #selector(self.play), for: .touchUpInside)
        
        music.favoriteButton.tag = indexPath.item
        music.favoriteButton.addTarget(self, action: #selector(self.fav), for: .touchUpInside)
        music.arrumalayout()
        
        return music
    }
    
    @objc func removeFav(_ notification: Notification) {
        musicCollectionView.reloadData()
        
    }
    
    @objc func stopMusic(_ notification: Notification) {
        player?.stop()
        guard let musicStop = musicCollectionView.cellForItem(at: [0,playingMusic ?? 0]) as? PlaylistCollectionViewCell else { return }
        musicStop.nome.textColor = UIColor(red: 0.00, green: 0, blue: 0, alpha: 1.00)
    }
    
    @IBAction func play(_ sender: UIButton) {
        guard let musicPlaying = musicCollectionView.cellForItem(at: [0,sender.tag]) as? PlaylistCollectionViewCell else { return }
        
        if let player = player, player.isPlaying {
            player.stop()
            let lastPlaying = musicCollectionView.cellForItem(at: [0,playingMusic ?? 0]) as? PlaylistCollectionViewCell
            lastPlaying?.nome.textColor = UIColor(red: 0.00, green: 0, blue: 0, alpha: 1.00)
            if musicPlaying != lastPlaying {
                play(sender)
            }
        }
        else {
            let urlString = Bundle.main.path(forResource: musicas[category ?? 0][sender.tag], ofType: "mp3")
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
                playingMusic = sender.tag
                musicPlaying.nome.textColor = UIColor(red: 1.00, green: 0.62, blue: 0.70, alpha: 1.00)
                NotificationCenter.default.post(name: Notification.Name("isPlaying"), object: nil)
            }
            catch {
                print("deu pau")
            }
        }
        
    }
    @IBAction func fav(_ sender: UIButton) {
        
        guard let musicPlaying = musicCollectionView.cellForItem(at: [0,sender.tag]) as? PlaylistCollectionViewCell else { return }
        
        if Favoritos.shared.favArray.contains(musicPlaying.nome.text ?? "algo") {
            musicPlaying.heart.image = UIImage(named: "PinkHeart")
            let indexFav = Favoritos.shared.favArray.firstIndex(of: musicPlaying.nome.text ?? "")
            Favoritos.shared.favArray.remove(at: indexFav ?? 0)
        }
        
        else {
            musicPlaying.heart.image = UIImage(named: "fullPinkHeart")
            Favoritos.shared.favArray += [musicas[category ?? 0][sender.tag]]
        }
        
        // SENDER
        NotificationCenter.default.post(name: Notification.Name("reloadFav"), object: nil)
    }
}
