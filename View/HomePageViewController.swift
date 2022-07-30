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
    
    var currencies = [Currency]()
    
    
    private var filmsTableViewModel : FilmsTableViewModel!
    
    //Holding Data Array
    var titleArray = [String]()
    var detailArray = [String]()
    var posterArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func getData(){
        let url = URL(string:"https://api.themoviedb.org/3/movie/550?api_key=50bbd6f582cd05dd01b18c5309bc9ae5")
     
    Webservices().getFilms(url: url!) { (film) in
        if let films = film {
            print("asdasd")
            print(films)
           // self.filmsTableViewModel = FilmsTableViewModel(newList: films)
        } else {
            print("asdmad")
        }
       // self.tableView.reloadData()
    }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellHomePageTableViewCell
        cell.titlePosterHome.text = currencies[indexPath.row].original_title
        cell.detailPosterHome.text = currencies[indexPath.row].overview
        cell.filmPosterHome.image = UIImage(named: "selectimage")
        return cell
    }

    
    //
    
//    func dowMovie(){
//
//        let urlString = "https://api.themoviedb.org/3/movie/550?api_key=50bbd6f582cd05dd01b18c5309bc9ae5"
//        let url = URL(string: urlString)
//
//        guard url != nil else{
//            print("Hata")
//            return
//        }
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: url!) { data, response, error in
//
//            if error == nil , data != nil {
//
//                let decoder = JSONDecoder()
//                do {
//                    let parsingData = try? decoder.decode(Fetch.self , from: data!)
//                    print(parsingData?.originalTitle)
//                    print("asdasd")
//                }catch {
//                    print("asd")
//                    print(error.localizedDescription)
//                }
//
//            }
//        }
//        dataTask.resume()
//
//    }
    
    
    // MARK: - Functions
    
    
//    let myApiUrl = "https://api.themoviedb.org/3/movie/550?api_key=50bbd6f582cd05dd01b18c5309bc9ae5"
//    
//    func getMovie() {
//        Alamofire.Request(url : myApiUrl , Method : HTTPMethod.get)
//        {
//            
//            
//        }
        
        
        
        
        
//        Alamofire.request("https://api.themoviedb.org/3/movie/550?api_key=50bbd6f582cd05dd01b18c5309bc9ae5").responseData { (resData) -> Void in
//              print(resData.result.value!)
//              let strOutput = String(data : resData.result.value!, encoding : String.Encoding.utf8)
//              print(strOutput)
//              let json = JSON(strOutput)
//
//            for index in 0...json.count{
//                let newCurrencies = Currency(
//                    original_title: json[index]["original_title"].stringValue,
//                    overview: json[index]["overview"].stringValue,
//                    poster_path: json[index]["poster_path"].stringValue)
//                self.currencies.append(newCurrencies)
//            }
//
//
//
//            self.tableView.reloadData()
//          }
//
//    }
}
