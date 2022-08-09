//
//  HomePageViewController.swift
//  MoveToZee
//
//  Created by haliliboswift on 29.07.2022.
//

import CoreData
import FirebaseFirestore
import Kingfisher
import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet var filmPosterHome: UIImageView!
    @IBOutlet var textPosterHome: UILabel!
    @IBOutlet var detailTextHome: UILabel!
    @IBOutlet var tableView: UITableView!

    var sendIndex = 0
    private var filmsTableViewModel: FilmsTableViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FireStorageManager().getLibrary()
        configureTableView()
        getMovies()
        navigationItem.title = "Movies"
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func getMovies() {
        Webservice().getMovies { movie, _ in
            if let movie = movie {
                self.filmsTableViewModel = FilmsTableViewModel(newList: movie)
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func starButtonClicked(_ sender: UIButton) {
        let point = tableView.convert(CGPoint.zero, from: sender)
        if let indexPath = tableView.indexPathForRow(at: point) {
            let movie = filmsTableViewModel.newList[indexPath.row]
            let title = movie.originalTitle
            let posterpath = movie.posterPath
            FireStorageManager().checkIsLibrary(title: title, imageUrl: posterpath!, index: indexPath.row)
        }
    }

    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
        let point = tableView.convert(CGPoint.zero, from: sender)
        if let indexPath = tableView.indexPathForRow(at: point) {
            let movie = filmsTableViewModel.newList[indexPath.row]
            CellHomePageTableViewCell.selectedMovie = movie
            let baseUrl = "https://image.tmdb.org/t/p/w500"
            let fullUrl = baseUrl + movie.posterPath!
            CoreDataManager().checkMovieIsFavorite(movie: movie)
        }
    }

}


extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    
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

    // Segue && Tableview
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendIndex = indexPath.row
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.getIndex = sendIndex
            destinationVC.segue = 1
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 176
    }
    
}
