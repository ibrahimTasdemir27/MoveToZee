//
//  HomePageViewController.swift
//  MoveToZee
//
//  Created by haliliboswift on 29.07.2022.
//

import UIKit

class HomePageViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    //UIView
    @IBOutlet weak var filmPosterHome: UIImageView!
    @IBOutlet weak var textPosterHome: UILabel!
    @IBOutlet weak var detailTextHome: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //Holding Data Array
    var titleArray = [String]()
    var detailArray = [String]()
    var posterArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
         
        
        
            let url = URL(string:"https://api.themoviedb.org/3/movie/550?api_key=50bbd6f582cd05dd01b18c5309bc9ae5")
         
        Webservices().getFilms(url: url!) { (film) in
            if let film = film {
                print(film)
            }
        }
         
        
      
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellHomePageTableViewCell
        cell.titlePosterHome.text = "adasd"
        cell.detailPosterHome.text = "sadsd"
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
}
