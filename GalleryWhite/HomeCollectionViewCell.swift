//
//  HomeCollectionViewCell.swift
//  CodeTest
//
//  Created by Manh Nguyen Ngoc on 20/01/2021.
//

import UIKit

protocol HomeCollectionViewCellDelegate: class {
    func homeCollectionViewCell(_ view: HomeCollectionViewCell, didTapSelectButtonIn file: File)
}

class HomeCollectionViewCell: UICollectionViewCell {

    // MARK: - UI
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectedButton: UIButton!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    
    // MARK: - Property
    static let identifier = "HomeCollectionViewCell"
    static let numberColumn: CGFloat = 3
    static let cellSpacing: CGFloat = 8.0
    
    weak var delegate: HomeCollectionViewCellDelegate?
    var file: File?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Custom cell
    public func setupData(with file: File) {
        self.file = file
        
        if file.nameImage == "camera" {
            selectedButton.isHidden = true
        }
        else {
            selectedButton.isHidden = false
        }
        
        imageView.image = UIImage(named: file.nameImage)
        
        if file.isSelected {
            selectedButton.setImage(UIImage(named: "Vector-4"), for: .normal)
        }
        else{
            selectedButton.setImage(UIImage(named: "Vector-3"), for: .normal)
        }
        
        self.imageView.layer.cornerRadius = self.imageView.frame.width / 20
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
    
    // MARK: - Scale image
    @IBAction func selectedButtonAction(_ sender: Any) {
        file?.isSelected = !file!.isSelected
        
        if file!.isSelected {
            selectedButton.setImage(UIImage(named: "Vector-4"), for: .normal)
            delegate?.homeCollectionViewCell(self, didTapSelectButtonIn: file!)
            scaleImage(15)
        }
        else {
            selectedButton.setImage(UIImage(named: "Vector-3"), for: .normal)
            delegate?.homeCollectionViewCell(self, didTapSelectButtonIn: file!)
            scaleImage(0)
        }
    }
}
