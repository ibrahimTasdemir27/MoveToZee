//
//  MyFilmsViewController.swift
//  MoveToZee
//
//  Created by haliliboswift on 4.08.2022.
//


import Foundation
import UIKit
import FirebaseFirestore
import Kingfisher
import Alamofire

class MyFilmsViewController: UIViewController  {
    
    
    let firestoreDatabase = Firestore.firestore()
    var titleArray = [String]()
    var imageArray = [String]()
    var indexArray = [Int]()
    var documentIDArray = [String]()
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.collectionView.reloadData()
            
            print(self.titleArray)
            print(self.imageArray)
        }
        
    
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return titleArray.count
   }
     
    
    override func viewWillAppear(_ animated: Bool) {
        getLibrary()
        self.collectionView.reloadData()
    }
    
    
    func getLibrary() {
       //Verileri çekmek
        firestoreDatabase.collection("Library").addSnapshotListener { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let snapshot = snapshot {
                self.documentIDArray.removeAll(keepingCapacity: false)
                self.indexArray.removeAll(keepingCapacity: false)
                self.imageArray.removeAll(keepingCapacity: false)
                self.titleArray.removeAll(keepingCapacity: false)
                
                for document in snapshot.documents{
                    if let title = document.get("title") as? String{
                        self.titleArray.append(title)
                        
                    
                    }
                    if let imageUrl = document.get("imageUrl") as? String {
                        self.imageArray.append(imageUrl)
                    
                    }
                    if let index = document.get("index") as? Int{
                        self.indexArray.append(index)
                    }
                    if let documentID = document.documentID as? String{
                        self.documentIDArray.append(documentID)
                    }
                }
                self.collectionView.reloadData()
            }
            
        }
    }
}

  extension MyFilmsViewController : UICollectionViewDataSource , UICollectionViewDelegate {
      
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryCell", for: indexPath) as! MyFilmsCellCollectionViewCell
        let processor = DownsamplingImageProcessor(size: self.collectionView.bounds.size)
        let url = "https://image.tmdb.org/t/p/w500" + imageArray[indexPath.row]
        cell.libraryLabel.text = self.titleArray[indexPath.row]
//         cell.libraryImages.layer.borderWidth = 3
         cell.layer.cornerRadius = 8
//         cell.libraryImages.layer.borderColor = UIColor.black.cgColor
         cell.libraryImages.kf.setImage(with: URL(string: url), placeholder: .none, options: [.processor(processor) , .scaleFactor(UIScreen.main.scale) , .transition(.fade(0)) , .cacheOriginalImage], completionHandler: .none)
         

//        cell.libraryLabel.text = "testtext"
        //cell.libraryImages.image = UIImage.init(named: "selectimage")
        return cell
    }
    
    
    }

//    extension MyFilmsViewController : UICollectionViewDelegateFlowLayout {
//
//        func collectionView(_ collectionView : UICollectionView , layoutcollectionViewLayout : UICollectionViewLayout , sizeForItemAt indexPath : IndexPath) -> CGSize {
//            return CGSize(width : 200 , height : 300)
//}
//
//}


