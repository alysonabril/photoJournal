//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Alyson Abril on 1/14/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
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
    override func viewWillAppear(_ animated: Bool) {
        allJournalImages = PhotoJournalModel.getPhotoJournal()
    }

}

/*
 first view controller
 collectionView
 cell - image, barbutton, and two labels: 1- title, 2- date
 uitoolbar bar button item - segues to second view controller
 clicking on cell will segue to "google the thing"
 
 
 
 second view controller
 two barbuttons on top: 1- cancel, 2- save
 uitextview
 uiimage
 uitoolbar 2 barbuttons: 1- photoLibrary, 2- camera
 
actionController
 (.alert)
 imageview?
 uiActivityView
 alertcontroller: alert, actionSheet
 
 BONUS:
 long press to view full image
 
 */
