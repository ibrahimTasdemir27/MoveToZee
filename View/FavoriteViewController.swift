//
//  FavoriteViewController.swift
//  MoveToZee
//
//  Created by haliliboswift on 29.07.2022.
//

import CoreData
import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var titleMovieArray = [String]()
    var detailMovieArray = [String]()
    var imageMovieArray = [UIImage]()
    var idMovieArray = [UUID]()
    var indexFavoriteArray = [Int]()

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
   
        getFavorite()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleMovieArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as! FavoriteTableViewCell
        cell.favoriteTitleLabel.text = titleMovieArray[indexPath.row]
        cell.favoriteDetailLabel.text = detailMovieArray[indexPath.row]
        cell.favoriteImageView.image = imageMovieArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            delFavorite(index: indexPath.row)
            idMovieArray.remove(at: indexPath.row)
            imageMovieArray.remove(at: indexPath.row)
            titleMovieArray.remove(at: indexPath.row)
            detailMovieArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func getFavorite() {
        titleMovieArray.removeAll()
        detailMovieArray.removeAll()
        imageMovieArray.removeAll()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieDatabase")

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let results = try context.fetch(fetchRequest)

            for result in results as! [NSManagedObject] {
                if let title = result.value(forKey: "titleMovie") as? String {
                    titleMovieArray.append(title)
                    print(title)
                }
                if let detail = result.value(forKey: "detailMovie") as? String {
                    detailMovieArray.append(detail)
                    print("detailok")
                }
                if let image = result.value(forKey: "imageMovie") as? Data {
                    let images = UIImage(data: image)
                    imageMovieArray.append(images!)
                    print("imageok")
                }
                if let id = result.value(forKey: "id") as? UUID {
                    idMovieArray.append(id)
                }
            }

        } catch {
            print("Hata var ")
        }
    }

    func delFavorite(index : Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
       
            let uuidString = idMovieArray[index].uuidString

            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieDatabase")
            fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
            fetchRequest.returnsObjectsAsFaults = false

            do {
                let results = try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject] {
                    if let id = result.value(forKey: "id") as? UUID {
                        if id == idMovieArray[index] {
                            context.delete(result)
                           
                            do{
                                try context.save()
                            }catch{
                                print("Silinemedi")
                            }
                        }
                    }
                }
            } catch {
                print("Hata")
            }
        
    }
}
