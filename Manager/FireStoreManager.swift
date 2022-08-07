//
//  FireStoreManager.swift
//  MoveToZee
//
//  Created by haliliboswift on 4.08.2022.
//

import Foundation
import UIKit
import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import Kingfisher

class FireStorageManager {
    
    static let shared = FireStorageManager()
    let firestoreDatabase = Firestore.firestore()
    var titleArray = [String]()
    var imageArray = [String]()
    var indexArray = [Int]()
    var documentIDArray = [String]()
   
   
    
    
    func getLibrary() {
       //Verileri çekmek
        firestoreDatabase.collection("Library").addSnapshotListener{ snapshot, error in
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
            }
            
            
        }
        
        
        
//        firestoreDatabase.collection("Library").addSnapshotListener { snapshot, error in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//            if let snapshot = snapshot {
//                self.documentIDArray.removeAll(keepingCapacity: false)
//                self.indexArray.removeAll(keepingCapacity: false)
//                self.imageArray.removeAll(keepingCapacity: false)
//                self.titleArray.removeAll(keepingCapacity: false)
//
//                for document in snapshot.documents{
//                    if let title = document.get("title") as? String{
//                        self.titleArray.append(title)
//
//
//                    }
//                    if let imageUrl = document.get("imageUrl") as? String {
//                        self.imageArray.append(imageUrl)
//
//                    }
//                    if let index = document.get("index") as? Int{
//                        self.indexArray.append(index)
//                    }
//                    if let documentID = document.documentID as? String{
//                        self.documentIDArray.append(documentID)
//                    }
//                }
//            }
//
//        }
    }
    
    func deleteLibrary(index : Int){
        var deleting : String?
        firestoreDatabase.collection("Library").getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let snapshot = snapshot {
                for document in snapshot.documents{
                    if index == document.get("index") as! Int{
                        deleting = document.documentID
                        self.firestoreDatabase.collection("Library").document(deleting!).delete()
                        
                    }
                }
            }
        }
        
        
    }
    
    func checkIsLibrary(title : String , imageUrl : String ,index : Int){
    
        firestoreDatabase.collection("Library").addSnapshotListener{ snapshot, error in
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
                    print(self.indexArray)
                }
                
            }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            var count = 0
            for i in self.indexArray {
                if index == i {
                    count += 1
                }
            }
            switch count {
                
            case 0 :
                self.saveLibrary(title: title, imageUrl: imageUrl, index: index)
            case 1 :
                self.deleteLibrary(index: index)
            default : self.deleteLibrary(index: index)
            }
        }
    
        }
    
    func saveLibrary(title : String , imageUrl : String , index : Int){
        //Veri Kaydetme
        let firestorePost = ["title" : title , "imageUrl" : imageUrl , "index" : index , "Time" : FieldValue.serverTimestamp()] as [String : Any]
        firestoreDatabase.collection("Library").addDocument(data: firestorePost) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    

    


}


    
//Butona tıklanacak
//Title ve image firebase eklenecek
