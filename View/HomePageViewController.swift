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

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var filmPosterHome: UIImageView!
    @IBOutlet var textPosterHome: UILabel!
    @IBOutlet var detailTextHome: UILabel!
    @IBOutlet var tableView: UITableView!

    private var filmsTableViewModel: FilmsTableViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getTitleDetailImage()
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
        cell.backgroundColor = .black
        cell.setImage(movie: film)
        return cell
    }
}


