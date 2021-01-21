//
//  Image.swift
//  CodeTest
//
//  Created by Manh Nguyen Ngoc on 20/01/2021.
//

import Foundation

// MARK: - Data of GalleryWhite
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

// MARK: - Data of GalleryBlack
class FileImage {
    
    var id = UUID().uuidString
    var nameImage = ""
    var turnSelected = 0
    
    convenience init(nameImage: String, turnSelected: Int) {
        self.init()
        self.nameImage = nameImage
        self.turnSelected = turnSelected
    }
    
}
