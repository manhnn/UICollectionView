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
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    
    static let identifier = "HomeCollectionViewCell"
    static let columnNumber: CGFloat = 3
    static let cellSpacing: CGFloat = 8.0
    
    weak var delegate: HomeCollectionViewCellDelegate?
    var image: Image?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Custom cell
    public func setupData(with image: Image) {
        self.image = image
        
        if image.nameImage == "camera" {
            selectedButton.isHidden = true
        }
        else {
            selectedButton.isHidden = false
        }
        
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
    fileprivate func scaleImage(_ sizeScale: CGFloat) {
        UIView.animate(withDuration: 1.5, animations: {
            self.imageViewTrailingConstraint.constant = sizeScale
            self.imageViewLeadingConstraint.constant = sizeScale
            self.imageViewTopConstraint.constant = sizeScale
            self.imageViewBottomConstraint.constant = sizeScale
        })
    }
    
    @IBAction func selectedButtonAction(_ sender: Any) {
        if let index = listImages.firstIndex(where: {$0.id == image!.id}) {
            listImages[index].isSelected  = !listImages[index].isSelected
        }
        
        if image!.isSelected {
            selectedButton.setImage(UIImage(named: "Vector-4"), for: .normal)
            delegate?.homeCollectionViewCell(self, didTapSelectButtonIn: image!)
            scaleImage(15)
        }
        else {
            selectedButton.setImage(UIImage(named: "Vector-3"), for: .normal)
            delegate?.homeCollectionViewCell(self, didTapSelectButtonIn: image!)
            scaleImage(0)
        }
    }
}
