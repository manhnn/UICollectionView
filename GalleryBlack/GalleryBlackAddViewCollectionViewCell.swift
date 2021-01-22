//
//  GalleryBlackAddViewCollectionViewCell.swift
//  CodeTest
//
//  Created by Manh Nguyen Ngoc on 21/01/2021.
//

import UIKit

protocol GalleryBlackAddViewCollectionViewCellDelegate {
    func galleryBlackAddViewCollectionViewCell(_ view: GalleryBlackAddViewCollectionViewCell, DidTapUnSelectButtonIn fileImage: FileImage)
}

class GalleryBlackAddViewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = "GalleryBlackAddViewCollectionViewCell"
    var fileImage: FileImage?
    var delegate: GalleryBlackAddViewCollectionViewCellDelegate?
    
    static let cellSpacing: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func setupData(with fileImage: FileImage) {
        self.fileImage = fileImage
        self.imageView.image = UIImage(named: fileImage.nameImage)
    }
    
    @IBAction func unSelectButtonAction(_ sender: Any) {
        self.delegate?.galleryBlackAddViewCollectionViewCell(self, DidTapUnSelectButtonIn: fileImage!)
        
    }
    
}
