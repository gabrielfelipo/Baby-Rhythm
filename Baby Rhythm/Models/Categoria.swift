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
    let imagem: String;
    
    init(titulo: String, descricao: String, imagem: String)
    {
        self.titulo = titulo
        self.descricao = descricao
        self.imagem = imagem
    }
}
