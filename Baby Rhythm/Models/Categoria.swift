//
//  Categoria.swift
//  Baby Rhythm
//
//  Created by gabrielfelipo on 17/05/22.
//

import Foundation
import UIKit

class Categoria {
    let titulo: String;
    let descricao: String;
    let cor: UIColor;
    
    init(titulo: String, descricao: String, cor: UIColor)
    {
        self.titulo = titulo
        self.descricao = descricao
        self.cor = cor
    }
}
