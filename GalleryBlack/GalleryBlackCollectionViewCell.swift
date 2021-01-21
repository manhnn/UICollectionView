//
//  GalleryBlackCollectionViewCell.swift
//  CodeTest
//
//  Created by Manh Nguyen Ngoc on 21/01/2021.
//

import UIKit

class GalleryBlackCollectionViewCell: UICollectionViewCell {

    // MARK: - UI
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var numberSelectedLabel: UILabel!
    
    // MARK: - Property
    static let identifier = "GalleryBlackCollectionViewCell"
    static let numberColumn: CGFloat = 4
    static let cellSpacing: CGFloat = 1.5
    
    var file: FileImage?
    let selectedImageAlpha: CGFloat = 0.65
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setupData(with file: FileImage) {
        self.file = file
        self.imageView.image = UIImage(named: file.nameImage)
        self.numberSelectedLabel.isHidden = (file.turnSelected != 0) ? false : true
        self.imageView.alpha = (file.turnSelected != 0) ? selectedImageAlpha : 1
        self.numberSelectedLabel.text = file.turnSelected < 10 ? "0\(file.turnSelected)" : "\(file.turnSelected)"
    }
    
    public func didSelectItem(with turnSelected: Int) {
        self.imageView.alpha = (turnSelected != 0) ? selectedImageAlpha : 1
    
        self.numberSelectedLabel.isHidden = (turnSelected != 0) ? false : true
        self.numberSelectedLabel.text = turnSelected < 10 ? "0\(turnSelected)" : "\(turnSelected)"
    }

}
