//
//  HomeCollectionViewCell.swift
//  CodeTest
//
//  Created by Manh Nguyen Ngoc on 20/01/2021.
//

import UIKit

protocol HomeCollectionViewCellDelegate: class {
    func homeCollectionViewCell(_ view: HomeCollectionViewCell, didTapSelectButtonIn image: Image)
}

class HomeCollectionViewCell: UICollectionViewCell {

    // MARK: - UI
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectedButton: UIButton!
    
    static let identifier = "HomeCollectionViewCell"
    static let columnCount: CGFloat = 3
    static let cellSpacing: CGFloat = 8.0
    
    var image: Image?
    weak var delegate: HomeCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Custom cell
    public func setupData(with image: Image) {
        self.image = image
        imageView.image = UIImage(named: image.nameImage)
        
        if image.isSelected == true {
            selectedButton.setImage(UIImage(named: "Vector-4"), for: .normal)
        }
        else{
            selectedButton.setImage(UIImage(named: "Vector-3"), for: .normal)
        }
        
        self.imageView.layer.cornerRadius = self.imageView.frame.width / 20
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "HomeCollectionViewCell", bundle: nil)
    }
    
    // MARK: - Button Action
    @IBAction func selectedButtonAction(_ sender: Any) {
        if let index = listImages.firstIndex(where: {$0.id == image!.id}) {
            listImages[index].isSelected  = !listImages[index].isSelected
        }
        delegate?.homeCollectionViewCell(self, didTapSelectButtonIn: image!)
        
        if ((image?.isSelected) != nil) {
            selectedButton.setImage(UIImage(named: "Vector-4"), for: .normal)
        }
        else {
            selectedButton.setImage(UIImage(named: "Vector-3"), for: .normal)
        }
    }
}
