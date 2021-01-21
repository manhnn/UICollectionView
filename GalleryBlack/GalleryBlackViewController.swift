//
//  GalleryBlackViewController.swift
//  CodeTest
//
//  Created by Manh Nguyen Ngoc on 21/01/2021.
//

import UIKit

class GalleryBlackViewController: UIViewController {
    
    // MARK: - Data local
    private var listFiles = [
        FileImage.init(nameImage: "image 12", turnSelected: 0),
        FileImage.init(nameImage: "image 13", turnSelected: 0),
        FileImage.init(nameImage: "image 14", turnSelected: 0),
        FileImage.init(nameImage: "image 13", turnSelected: 0),
        FileImage.init(nameImage: "image 21", turnSelected: 0),
        FileImage.init(nameImage: "image 14", turnSelected: 0),
        FileImage.init(nameImage: "image 15", turnSelected: 0),
        FileImage.init(nameImage: "image 25", turnSelected: 0),
        FileImage.init(nameImage: "image 15", turnSelected: 0),
        FileImage.init(nameImage: "image 16", turnSelected: 0),
        FileImage.init(nameImage: "image 17", turnSelected: 0),
        FileImage.init(nameImage: "image 18", turnSelected: 0),
        FileImage.init(nameImage: "image 19", turnSelected: 0),
        FileImage.init(nameImage: "image 20", turnSelected: 0),
        FileImage.init(nameImage: "image 21", turnSelected: 0),
        FileImage.init(nameImage: "image 23", turnSelected: 0),
        FileImage.init(nameImage: "image 24", turnSelected: 0),
        FileImage.init(nameImage: "image 25", turnSelected: 0),
        FileImage.init(nameImage: "image 26", turnSelected: 0),
        FileImage.init(nameImage: "image 23", turnSelected: 0),
        FileImage.init(nameImage: "image 24", turnSelected: 0),
        FileImage.init(nameImage: "image 12", turnSelected: 0),
        FileImage.init(nameImage: "image 13", turnSelected: 0),
        FileImage.init(nameImage: "image 21", turnSelected: 0),
        FileImage.init(nameImage: "image 14", turnSelected: 0),
        FileImage.init(nameImage: "image 15", turnSelected: 0),
        FileImage.init(nameImage: "image 12", turnSelected: 0),
        FileImage.init(nameImage: "image 13", turnSelected: 0),
        FileImage.init(nameImage: "image 14", turnSelected: 0),
        FileImage.init(nameImage: "image 13", turnSelected: 0),
        FileImage.init(nameImage: "image 25", turnSelected: 0),
        FileImage.init(nameImage: "image 26", turnSelected: 0),
        FileImage.init(nameImage: "image 16", turnSelected: 0),
        FileImage.init(nameImage: "image 17", turnSelected: 0),
        FileImage.init(nameImage: "image 19", turnSelected: 0),
        FileImage.init(nameImage: "image 20", turnSelected: 0),
        FileImage.init(nameImage: "image 18", turnSelected: 0)
     ]

    public var listSelectedFiles = [FileImage]()
    
    // MARK: - UI
    @IBOutlet weak var subAddView: UIView!
    @IBOutlet weak var galleryBlackCollectionView: UICollectionView!
    @IBOutlet weak var subAddCollectionView: UICollectionView!
    
    @IBOutlet weak var CollectionviewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: GalleryBlackCollectionViewCell.identifier, bundle: nil)
        galleryBlackCollectionView.register(nib, forCellWithReuseIdentifier: GalleryBlackCollectionViewCell.identifier)
        galleryBlackCollectionView.delegate = self
        galleryBlackCollectionView.dataSource = self
        
        let subCollectionViewFlowLayout = UICollectionViewFlowLayout()
        subAddCollectionView.setCollectionViewLayout(subCollectionViewFlowLayout, animated: true)
        subCollectionViewFlowLayout.scrollDirection = .horizontal
        let marginSize = subAddView.bounds.height / 5
        subCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: marginSize, bottom: 0, right: marginSize)
        let subNib = UINib(nibName: GalleryBlackAddViewCollectionViewCell.identifier, bundle: nil)
        subAddCollectionView.register(subNib, forCellWithReuseIdentifier: GalleryBlackAddViewCollectionViewCell.identifier)
        subAddCollectionView.delegate = self
        subAddCollectionView.dataSource = self
    }
}

// MARK: - Extension UICollectionViewDelegate
extension GalleryBlackViewController: UICollectionViewDelegate {
    public func updateContraintBottomOfCollectionView() {
        // update Bottom Constraint of CollectionView
        if listSelectedFiles.count != 0 {
            CollectionviewBottomConstraint.constant = subAddView.bounds.height
            subAddView.isHidden = false
        }
        else {
            subAddView.isHidden = true
            self.CollectionviewBottomConstraint.constant = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == galleryBlackCollectionView {
            let cell = galleryBlackCollectionView.cellForItem(at: indexPath) as! GalleryBlackCollectionViewCell
            if listFiles[indexPath.row].turnSelected == 0 {
                listSelectedFiles.append(listFiles[indexPath.row])
                listFiles[indexPath.row].turnSelected = listSelectedFiles.count
            }
            else {
                if let indexFirst = listSelectedFiles.firstIndex(where: {$0.id == listFiles[indexPath.row].id}) {
                    listSelectedFiles.remove(at: indexFirst)
                    listFiles[indexPath.row].turnSelected = 0
                    for index in indexFirst..<listSelectedFiles.count {
                        listSelectedFiles[index].turnSelected -= 1
                        if let index2 = listFiles.firstIndex(where: {$0.id == listSelectedFiles[index].id}) {
                            listFiles[index2].turnSelected = listSelectedFiles[index].turnSelected
                        }
                    }
                    
                }
                galleryBlackCollectionView.reloadData()
            }
            subAddCollectionView.reloadData()
            cell.didSelectItem(with: listFiles[indexPath.row].turnSelected)
            
            
            updateContraintBottomOfCollectionView()
        }
    }
}

// MARK: - Extension UICollectionViewDataSource
extension GalleryBlackViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == subAddCollectionView {
            return listSelectedFiles.count
        }
        return listFiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == galleryBlackCollectionView {
            let cell = galleryBlackCollectionView.dequeueReusableCell(withReuseIdentifier: GalleryBlackCollectionViewCell.identifier, for: indexPath) as! GalleryBlackCollectionViewCell
            
            cell.setupData(with: listFiles[indexPath.row])
            return cell
        }
        let cell = subAddCollectionView.dequeueReusableCell(withReuseIdentifier: GalleryBlackAddViewCollectionViewCell.identifier, for: indexPath) as! GalleryBlackAddViewCollectionViewCell
        cell.delegate = self
        cell.setupData(with: listSelectedFiles[indexPath.row])
        
        return cell
    }
}

// MARK: - Extension UICollectionViewFlowLayout
extension GalleryBlackViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == galleryBlackCollectionView {
            let width = (UIScreen.main.bounds.width - (GalleryBlackCollectionViewCell.numberColumn - 1) * GalleryBlackCollectionViewCell.cellSpacing) / GalleryBlackCollectionViewCell.numberColumn
            let height = width
            return CGSize(width: width, height: height)
        }
        let height = subAddView.bounds.height * (2 / 3)
        let width = height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == galleryBlackCollectionView {
            return GalleryBlackCollectionViewCell.cellSpacing
        }
        return GalleryBlackAddViewCollectionViewCell.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == galleryBlackCollectionView {
            return GalleryBlackCollectionViewCell.cellSpacing
        }
        return GalleryBlackAddViewCollectionViewCell.cellSpacing
    }
}

// MARK: - GalleryBlackAddViewCollectionViewCellDelegate
extension GalleryBlackViewController: GalleryBlackAddViewCollectionViewCellDelegate {
    func galleryBlackAddViewCollectionViewCell(_ view: GalleryBlackAddViewCollectionViewCell, DidTapUnSelectButtonIn fileImage: FileImage) {
        // Remove in listSelectedFiles
        if let indexFirst = listSelectedFiles.firstIndex(where: {$0.id == fileImage.id}) {
            if let index2 = listFiles.firstIndex(where: {$0.id == listSelectedFiles[indexFirst].id}) {
                listFiles[index2].turnSelected = 0
            }
            listSelectedFiles.remove(at: indexFirst)
            
            subAddCollectionView.reloadData()
            
            for index in indexFirst..<listSelectedFiles.count {
                listSelectedFiles[index].turnSelected -= 1
                if let index2 = listFiles.firstIndex(where: {$0.id == listSelectedFiles[index].id}) {
                    listFiles[index2].turnSelected = listSelectedFiles[index].turnSelected
                }
            }
            galleryBlackCollectionView.reloadData()
            updateContraintBottomOfCollectionView()
        }
    }
}
