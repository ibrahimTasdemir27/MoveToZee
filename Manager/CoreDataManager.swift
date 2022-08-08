//
//  CoreDataManager.swift
//  MoveToZee
//
//  Created by haliliboswift on 2.08.2022.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    var movieidArray = [Int]()
    
    
    
    func checkMovieIsFavorite(movie: MovieResultModel) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewMovieDatabase")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject]{
                if let id = result.value(forKey: "movieID") as? Int{
                    movieidArray.append(id)
                }
            }
        }catch{
            print(error.localizedDescription)
        }
        switch movieidArray.contains(movie.id){
            case true:
                deleteFromFavorites(id: movie.id)
            case false:
            saveTodFavorites(movie: movie)
            default:break
            }
        return true
    }
    
    
    func saveTodFavorites(movie: MovieResultModel) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let movieDatabase = NSEntityDescription.insertNewObject(forEntityName: "NewMovieDatabase", into: context)
        movieDatabase.setValue(movie.id, forKey: "movieID")
        movieDatabase.setValue(movie.originalTitle, forKey: "movieTitle")
        movieDatabase.setValue(movie.overview, forKey: "movieDetail")
        movieDatabase.setValue(movie.posterPath, forKey: "posterURL")
        movieDatabase.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            print("başarılı")
            
        }catch{
            print(error.localizedDescription)
        }
    }
        
    func deleteFromFavorites(id: Int) {
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         let context = appDelegate.persistentContainer.viewContext
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewMovieDatabase")
         fetchRequest.predicate = NSPredicate(format: "movieID = %d", id)
         fetchRequest.returnsObjectsAsFaults = false
         
         do{
             let results = try context.fetch(fetchRequest)
             
             for result in results as! [NSManagedObject] {
                 if let idMovie = result.value(forKey: "movieID") as? Int{
                     if movieidArray.contains(idMovie){
                         context.delete(result)
                        
                         do{
                            try context.save()
                         }catch{
                             print(error.localizedDescription)
                         }
                     }
                 }
             }
        }
        catch{
             print("Hataa")
         }
    }
}
