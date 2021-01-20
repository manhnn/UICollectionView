//
//  HomeViewController.swift
//  CodeTest
//
//  Created by Manh Nguyen Ngoc on 19/01/2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    @IBOutlet weak var selectCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeCollectionViewFlowLayout = UICollectionViewFlowLayout()
        homeCollectionView.setCollectionViewLayout(homeCollectionViewFlowLayout, animated: true)
        homeCollectionViewFlowLayout.scrollDirection = .vertical
        homeCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: HomeCollectionViewCell.cellSpacing, left: HomeCollectionViewCell.cellSpacing, bottom: HomeCollectionViewCell.cellSpacing, right: HomeCollectionViewCell.cellSpacing)
        
        homeCollectionView.register(HomeCollectionViewCell.nib(), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
    }

}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("tapped me \(indexPath.row)")
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        cell.delegate = self
        cell.setupData(with: listImages[indexPath.row])
        print(indexPath.row)
        return cell
    }
}
 
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (UIScreen.main.bounds.width - (HomeCollectionViewCell.columnCount + 1) * HomeCollectionViewCell.cellSpacing) / HomeCollectionViewCell.columnCount
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

extension HomeViewController: HomeCollectionViewCellDelegate {
    func homeCollectionViewCell(_ view: HomeCollectionViewCell, didTapSelectButtonIn image: Image) {
        // add to Realm
    }
}
