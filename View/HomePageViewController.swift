//
//  HomePageViewController.swift
//  MoveToZee
//
//  Created by haliliboswift on 29.07.2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomePageViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    //UIView
    @IBOutlet weak var filmPosterHome: UIImageView!
    @IBOutlet weak var textPosterHome: UILabel!
    @IBOutlet weak var detailTextHome: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var getkeys = [GetKeys]()
    
    
    
    private var filmsTableViewModel : FilmsTableViewModel!
    
    
    //Holding Data Array
    var titleArray = [String]()
    var detailArray = [String]()
    var posterArray = [String]()
    var titleMovies = [MovieResultModel.CodingKeys.originalTitle]
    var detailMovies = [MovieResultModel]()
    let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=50bbd6f582cd05dd01b18c5309bc9ae5")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        veriAl()
        
        
    }
   
    func veriAl(){
        Webservice().getMovies{ movie, value in
            
            if let movie = movie{
                
                self.filmsTableViewModel = FilmsTableViewModel(newList: movie)
                self.tableView.reloadData()
                //print(movie[])
              //  self.titleMovies += movie
                //print(self.titleMovies)}
        }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmsTableViewModel == nil ? 0 : self.filmsTableViewModel.numberOfRowsInsection()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellHomePageTableViewCell
        let filmsViewModel = self.filmsTableViewModel.newsAtIndexPath(indexPath.row)
        cell.titlePosterHome.text = filmsViewModel.originalTitle
        cell.detailPosterHome.text = filmsViewModel.overview
        cell.filmPosterHome.image = UIImage(named: "selectimage")
        return cell
    }

    
   
}
