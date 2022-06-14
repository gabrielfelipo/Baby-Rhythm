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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        musicCollectionView.delegate = self
        musicCollectionView.dataSource = self
        
        
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
    
    let musicas = [["Crack Baby"],[],["I Will"],[]]
    var favorites: [String] = ["Crack Baby"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return musicas[category ?? 0].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let music = collectionView.dequeueReusableCell(withReuseIdentifier: "playlistCollectionCell", for: indexPath) as! PlaylistCollectionViewCell
        
        let musica = musicas[category ?? 0][indexPath.row]
        
        music.nome.text = musica
        music.imageView.image = UIImage(named: musica)
        
        music.playButton.tag = indexPath.item
        music.playButton.addTarget(self, action: #selector(self.play), for: .touchUpInside)
        
        music.favoriteButton.tag = indexPath.item
        music.favoriteButton.addTarget(self, action: #selector(self.fav), for: .touchUpInside)
        music.arrumalayout()
        
        return music
    }
    
    @IBAction func play(_ sender: UIButton) {
        if let player = player, player.isPlaying {
            player.stop()
            
            playColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
        }
        else {
            let urlString = Bundle.main.path(forResource: musicas[category ?? 0][sender.tag], ofType: "mp3")
            print("AQUI CARAI")
            print(Bundle.main)
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
                playColor = UIColor(red: 1.00, green: 0.85, blue: 0.61, alpha: 1.00)
                musicCollectionView.cellForItem(at: [0,sender.tag])
                
                //var cell = musicCollectionView.cellForItem(at: [0,0])
                
                player.play()
            }
            catch {
                print("deu pau")
            }
        }
        
    }
    @IBAction func fav(_ sender: UIButton) {
        //let music = Favoritos(musicas[category ?? 0][sender.tag])
        favoriteArray += [musicas[category ?? 0][sender.tag]]
        Favoritos.shared.favArray = favoriteArray
        
        
        // TA ESQUISITO ESSE BAGULHO AQUI Ó!! DA UMA OLHADA NAMORAL
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "FavoriteViewController")
        self.navigationController?.present(homeVC, animated: false, completion: nil)
        self.navigationController?.dismiss(animated: false, completion: nil)
    }
}
