//
//  ViewController.swift
//  Flixter-Swift
//
//  Created by BRIAN BETANCOURT on 2/25/22.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let movie = movies[indexPath.row]
        
        let title = movie["title"] as! String
        
        
        cell.textLabel?.text = title
        
        
       
        
        
        return cell
    }
    
    
    

    @IBOutlet weak var tableView: UITableView!
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=2bda2b0832cca9081ef2eb9aba8bc08b")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                 self.movies = dataDictionary["results"] as! [[String:Any]]
                 
                 self.tableView.reloadData()

             }
        }
        task.resume()
        
        
        // Do any additional setup after loading the view.
    }


}
