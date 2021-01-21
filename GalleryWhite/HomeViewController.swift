//
//  HomeViewController.swift
//  CodeTest
//
//  Created by Manh Nguyen Ngoc on 19/01/2021.
//

import UIKit

class HomeViewController: UIViewController {
    private var listFiles = [
        File.init(nameImage: "camera", isSelected: false),
        File.init(nameImage: "image 12", isSelected: false),
        File.init(nameImage: "image 13", isSelected: false),
        File.init(nameImage: "image 14", isSelected: false),
        File.init(nameImage: "image 15", isSelected: false),
        File.init(nameImage: "image 16", isSelected: false),
        File.init(nameImage: "image 17", isSelected: false),
        File.init(nameImage: "image 18", isSelected: false),
        File.init(nameImage: "image 19", isSelected: false),
        File.init(nameImage: "image 20", isSelected: false),
        File.init(nameImage: "image 21", isSelected: false),
        File.init(nameImage: "image 23", isSelected: false),
        File.init(nameImage: "image 24", isSelected: false),
        File.init(nameImage: "image 25", isSelected: false),
        File.init(nameImage: "image 26", isSelected: false),
        File.init(nameImage: "image 23", isSelected: false),
        File.init(nameImage: "image 24", isSelected: false),
        File.init(nameImage: "image 12", isSelected: false),
        File.init(nameImage: "image 13", isSelected: false),
        File.init(nameImage: "image 21", isSelected: false),
        File.init(nameImage: "image 14", isSelected: false),
        File.init(nameImage: "image 15", isSelected: false),
        File.init(nameImage: "image 25", isSelected: false),
        File.init(nameImage: "image 26", isSelected: false),
        File.init(nameImage: "image 16", isSelected: false),
        File.init(nameImage: "image 17", isSelected: false),
        File.init(nameImage: "image 19", isSelected: false),
        File.init(nameImage: "image 20", isSelected: false),
        File.init(nameImage: "image 18", isSelected: false)
     ]

    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var selectedCountLabel: UILabel!
    
    var selectCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeCollectionViewFlowLayout = UICollectionViewFlowLayout()
        homeCollectionView.setCollectionViewLayout(homeCollectionViewFlowLayout, animated: true)
        homeCollectionViewFlowLayout.scrollDirection = .vertical
        homeCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: HomeCollectionViewCell.cellSpacing, left: HomeCollectionViewCell.cellSpacing, bottom: HomeCollectionViewCell.cellSpacing, right: HomeCollectionViewCell.cellSpacing)
        
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        homeCollectionView.register(nib, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if indexPath.row == 0 {
            // show camera
        }
        else {
            print("tapped me \(indexPath.row)")
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listFiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        cell.delegate = self
        cell.setupData(with: listFiles[indexPath.row])
        return cell
    }
}
 
// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (UIScreen.main.bounds.width - (HomeCollectionViewCell.numberColumn + 1) * HomeCollectionViewCell.cellSpacing) / HomeCollectionViewCell.numberColumn
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return HomeCollectionViewCell.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return HomeCollectionViewCell.cellSpacing
    }
}

// MARK: - HomeCollectionViewCellDelegate
extension HomeViewController: HomeCollectionViewCellDelegate {
    func homeCollectionViewCell(_ view: HomeCollectionViewCell, didTapSelectButtonIn image: File) {
        if let index = listFiles.firstIndex(where: {$0.id == image.id}) {
            if listFiles[index].isSelected {
                selectCount += 1
            }
            else {
                selectCount -= 1
            }
        }
        selectedCountLabel.text = selectCount > 0 ? "Select(\(selectCount))" : "Select"
    }
}
