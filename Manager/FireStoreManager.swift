//
//  FireStoreManager.swift
//  MoveToZee
//
//  Created by haliliboswift on 4.08.2022.
//

import FirebaseFirestore
import FirebaseStorage
import Foundation
import Kingfisher
import SwiftUI
import UIKit

class FireStorageManager {
    static let shared = FireStorageManager()
    let firestoreDatabase = Firestore.firestore()
    var libraryDict : [LibraryResultModel] = []
    var titleArray = [String]()
    var imageArray = [String]()
    var indexArray = [Int]()
    var documentIDArray = [String]()

    func getLibrary() {
        libraryDict = []
        firestoreDatabase.collection("Library").addSnapshotListener { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let snapshot = snapshot {
               
                for document in snapshot.documents {
                    let data = document.data()
                    print("data", data)
                    
                    if let title = data[LibraryResultModel.CodingKeys.title.rawValue] as? String,
                       let url = data[LibraryResultModel.CodingKeys.imageURL.rawValue] as? String,
                       let index = data[LibraryResultModel.CodingKeys.index.rawValue] as? Int {
                        let updatedData = LibraryResultModel(title: title, imageURL: url, index: index)
                    }
                }
            }
        }
    }
 
    
    func deleteLibrary(index: Int) {
        var deleting: String?
        firestoreDatabase.collection("Library").getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    if index == document.get("index") as! Int {
                        deleting = document.documentID
                        self.firestoreDatabase.collection("Library").document(deleting!).delete()
                    }
                }
            }
        }
    }

    
    
    func checkIsLibrary(title: String, imageUrl: String, index: Int) {
        var color = false
        firestoreDatabase.collection("Library").getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let snapshot = snapshot {
                self.indexArray.removeAll(keepingCapacity: false)
                for document in snapshot.documents {
                    if let index = document.get("index") as? Int {
                        self.indexArray.append(index)
                    }
                }
                var count = 0
                for i in self.indexArray {
                    if index == i {
                        count += 1
                    }
                }
                switch count {
                case 0:
                    self.saveLibrary(title: title, imageUrl: imageUrl, index: index)
                case 1:
                    color = false
                    self.deleteLibrary(index: index)
                default: break
                }
            }
        }
    }

    
    
    func saveLibrary(title: String, imageUrl: String, index: Int) {
        // Veri Kaydetme
        let firestorePost = ["original_title": title, "poster_path": imageUrl, "index": index, "Time": FieldValue.serverTimestamp()] as [String: Any]
        firestoreDatabase.collection("Library").addDocument(data: firestorePost) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
