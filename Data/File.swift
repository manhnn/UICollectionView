//
//  Image.swift
//  CodeTest
//
//  Created by Manh Nguyen Ngoc on 20/01/2021.
//

import Foundation

class File {
    
    var id = UUID().uuidString
    var nameImage = ""
    var isSelected = false
    
    convenience init(nameImage: String, isSelected: Bool) {
        self.init()
        self.nameImage = nameImage
        self.isSelected = isSelected
    }
    
}
