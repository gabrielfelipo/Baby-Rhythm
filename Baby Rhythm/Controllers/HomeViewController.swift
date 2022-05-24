//
//  ViewController.swift
//  Baby Rhythm
//
//  Created by gabrielfelipo on 16/05/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categorias: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        collectionView.topAnchor.constraint(equalTo: categorias.bottomAnchor, constant: 8).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.view.leftAnchor, constant: UIScreen.main.bounds.width-16).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    
    
    let categoria: [Categoria] = [Categoria(titulo: "Calma", descricao: "Playlist ideal para acalmar seu bebê, indicada para horários próximos ao do sono", cor: UIColor(red: 1.00, green: 0.62, blue: 0.70, alpha: 1.00)),
                Categoria(titulo: "Diversão", descricao: "Playlist ideal para acalmar seu bebê, indicada para horários próximos ao do sono", cor: UIColor(red: 1.00, green: 0.85, blue: 0.61, alpha: 1.00)),
                Categoria(titulo: "Soninho", descricao: "Playlist ideal para acalmar seu bebê, indicada para horários próximos ao do sono", cor: UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00)),
                Categoria(titulo: "Gerais", descricao: "Playlist ideal para acalmar seu bebê, indicada para horários próximos ao do sono", cor: UIColor(red: 1.00, green: 0.75, blue: 0.65, alpha: 1.00))
                                  
    ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categoria.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        
        let item = categoria[indexPath.row]
        
        cell.backgroundColor = item.cor
        cell.title.text = item.titulo
        cell.desc.text = item.descricao
        cell.layer.cornerRadius = 10
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 10)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.25
        cell.layer.masksToBounds = false
        
        return cell
    }

}

