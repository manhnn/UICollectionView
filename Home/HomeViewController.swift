//
//  HomeViewController.swift
//  CodeTest
//
//  Created by Manh Nguyen Ngoc on 19/01/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var imageTake: UIImageView!
    var imagePicker: UIImagePickerController!


    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    @IBOutlet weak var selectedCountLabel: UILabel!
    
    var selectCount: Int = 0
    
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

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
//            imagePicker =  UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = .camera
//            present(imagePicker, animated: true, completion: nil)
        }
        else {
            print("tapped me \(indexPath.row)")
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        cell.delegate = self
        cell.setupData(with: listImages[indexPath.row])
        return cell
    }
}
 
// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (UIScreen.main.bounds.width - (HomeCollectionViewCell.columnNumber + 1) * HomeCollectionViewCell.cellSpacing) / HomeCollectionViewCell.columnNumber
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
    func homeCollectionViewCell(_ view: HomeCollectionViewCell, didTapSelectButtonIn image: Image) {
        if image.isSelected {
            selectCount += 1
        }
        else {
            selectCount -= 1
        }
        selectedCountLabel.text = selectCount > 0 ? "Select(\(selectCount))" : "Select"
    }
}



// MARK: - Device camera ===========================================================================================
extension HomeViewController: UINavigationControllerDelegate {
    
    enum ImageSource {
        case photoLibrary
        case camera
    }


    //MARK: - Take image
    @IBAction func takePhoto(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            selectImageFrom(.photoLibrary)
            return
        }
        selectImageFrom(.camera)
    }

    func selectImageFrom(_ source: ImageSource){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }

    //MARK: - Saving Image here
    @IBAction func save(_ sender: AnyObject) {
        guard let selectedImage = imageTake.image else {
            print("Image not found!")
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
        }
    }

    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

// MARK: - ImagePickerControllerDelegate
extension HomeViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        imageTake.image = selectedImage
    }
}
