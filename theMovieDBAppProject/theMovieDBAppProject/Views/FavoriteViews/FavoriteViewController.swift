//
//  FavoriteViewController.swift
//  theMovieDBAppProject
//
//  Created by Serhii on 3/4/23.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var moviesViewModel = TrendingMediaViewModel()
    
    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var favoriteTypeSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        self.favoriteTableView.register(nib, forCellReuseIdentifier: "FavoriteTableViewCell")
    }
    
    
}

extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.moviesViewModel.arrayOfMovies.count
        switch favoriteTypeSegmentControl.selectedSegmentIndex {
        case 0:
            TrendingMediaViewModel.stateSegment = .movie
            self.moviesViewModel.arrayOfMovies.count
            
        case 1:
            TrendingMediaViewModel.stateSegment = .tv
            return moviesViewModel.arrayOfMovies.count
            
        default:
            fatalError("segment controll error")
        }
        return moviesViewModel.arrayOfMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell") as! FavoriteTableViewCell
        switch favoriteTypeSegmentControl.selectedSegmentIndex {
        case 0:
            //            cell.configure(with: moviesViewModel.arrayOfMovies[indexPath.row])
            break
            
        case 1:
            //            cell.configure(with: moviesViewModel.arrayOfTVShows[indexPath.row])
            break
        default:
            fatalError("segment controll error")
        }
        return cell
    }
}
