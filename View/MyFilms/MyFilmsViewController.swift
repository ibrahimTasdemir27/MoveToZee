//
//  MyFilmsViewController.swift
//  MoveToZee
//
//  Created by haliliboswift on 4.08.2022.
//

import Alamofire
import FirebaseFirestore
import Foundation
import Kingfisher
import UIKit

class MyFilmsViewController: UIViewController {
    let firestoreDatabase = Firestore.firestore()
    var libraryDict : [LibraryResultModel] = []
    var selectedIndex = 5
    
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Library"
        
        collectionView.dataSource = self
        collectionView.delegate = self

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.collectionView.reloadData()
        }
       
    }
    
    
    func getLibraryModel() {
        libraryDict = []
        firestoreDatabase.collection("Library").getDocuments { snapshot, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
            if let snapshotDocuments = snapshot?.documents {
                
                for doc in snapshotDocuments {
                    if let title = doc.data()[LibraryResultModel.CodingKeys.title.rawValue] as? String ,
                        let url = doc.data()[LibraryResultModel.CodingKeys.imageURL.rawValue] as? String,
                        let index = doc.data()[LibraryResultModel.CodingKeys.index.rawValue] as? Int {
                        let newLibrary = LibraryResultModel(title: title, imageURL: url , index: index)
                        self.libraryDict.append(newLibrary)
                    }
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    
   

    
    override func viewWillAppear(_ animated: Bool) {
        getLibraryModel()
        collectionView.reloadData()
    }
}


extension MyFilmsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryCell", for: indexPath) as! MyFilmsCellCollectionViewCell
        let processor = DownsamplingImageProcessor(size: self.collectionView.bounds.size)
        let url = "https://image.tmdb.org/t/p/w500" + libraryDict[indexPath.row].imageURL
        cell.layer.cornerRadius = 8
        cell.libraryImages.kf.setImage(with: URL(string: url), placeholder: .none, options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(0)), .cacheOriginalImage], completionHandler: .none)
        cell.libraryLabel.text = libraryDict[indexPath.row].title
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return libraryDict.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = libraryDict[indexPath.row].index
        performSegue(withIdentifier: "toDetailsVCLibrary", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVCLibrary" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.segue = 1
            destinationVC.getIndex = selectedIndex
            print("getIndex:" , selectedIndex )
        }
    }
    
    
    
}
