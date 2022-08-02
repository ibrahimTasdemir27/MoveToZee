//
//  HomePageViewController.swift
//  MoveToZee
//
//  Created by haliliboswift on 29.07.2022.
//

import Alamofire
import Kingfisher
import SwiftyJSON
import UIKit
import CoreData

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var filmPosterHome: UIImageView!
    @IBOutlet var textPosterHome: UILabel!
    @IBOutlet var detailTextHome: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var sendIndex = 0
    
    private var filmsTableViewModel: FilmsTableViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getTitleDetailImage()
        self.navigationItem.title = "Movies"
    }

    func getTitleDetailImage() {
        
        Webservice().getMovies { movie, _ in
            if let movie = movie {
                self.filmsTableViewModel = FilmsTableViewModel(newList: movie)
                self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmsTableViewModel == nil ? 0 : filmsTableViewModel.numberOfRowsInsection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellHomePageTableViewCell
        let film = filmsTableViewModel.newList[indexPath.row]
        var index = indexPath.row
        cell.setImage(movie: film)
        return cell
    }
    
    //Segue && Tableview
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sendIndex = indexPath.row
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 176
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.getIndex = sendIndex
            
        }
    }
    
    @objc  func callIndex(_ sender : Any ) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let movieCoreModel = NSEntityDescription.insertNewObject(forEntityName: "MovieDatabase", into: context)
        
        movieCoreModel.setValue(index, forKey: "index")
        
        do{
            try context.save()
            
            print("başarılı")
        }catch{
            print("hata var")
        }
        
        
    }
    
    
}



