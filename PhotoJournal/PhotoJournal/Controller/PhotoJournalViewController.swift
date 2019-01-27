//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Alyson Abril on 1/14/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoJournalViewController: UIViewController {


    @IBOutlet weak var photoCollection: UICollectionView!
    
    private var allJournalImages = PhotoJournalModel.getPhotoJournal() {
        didSet {
            photoCollection.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollection.dataSource = self
    }
    
    public var imageIndex: Int?
    private var isEditingList = false
    public var currentPhoto: PhotoJournal?
    
    override func viewWillAppear(_ animated: Bool) {
        allJournalImages = PhotoJournalModel.getPhotoJournal()
    }
    @IBAction func editButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "", message: "Choose Option", preferredStyle: .actionSheet)
       
        let editAction = UIAlertAction(title: "Edit", style: .default, handler: {(action) in
            PhotoJournalModel.editPhotos(photos: self.allJournalImages[sender.tag], atIndex: sender.tag)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "editStoryBoard") as?
                PhotoJournalDetailViewController else { return }
            viewController.imageIndex = sender.tag
            viewController.currentPhoto = self.allJournalImages[sender.tag]
            self.present(viewController, animated:  true, completion: nil)
        })
        
        let shareAction = UIAlertAction(title: "Share", style: .default, handler: { (action) in
            let shareText = self.allJournalImages[sender.tag].description
            if let image = UIImage(data: self.allJournalImages[sender.tag].imageData) {
                let vc = UIActivityViewController(activityItems: [shareText, image], applicationActivities: [])
                self.present(vc, animated: true)
            }
        })
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            PhotoJournalModel.deletePhotos(atIndex: sender.tag)
            self.allJournalImages = PhotoJournalModel.getPhotoJournal()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
        })
        
        alert.addAction(editAction)
        alert.addAction(shareAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension PhotoJournalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotoJournalModel.getPhotoJournal().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoJournalCell else {
            fatalError("cell error")
        }
        
        let photoCell = allJournalImages[indexPath.row]
        cell.createdDate.text = photoCell.dateFormattedString
        cell.photoTitle.text = photoCell.description
        
        if let image = UIImage.init(data: photoCell.imageData) {
            cell.collectionPhoto.image = image
            } else {
            print("Photo Display Error")
        }
        return cell
    }
}

extension PhotoJournalViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil {
            
        } else {
            print("Image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
}
