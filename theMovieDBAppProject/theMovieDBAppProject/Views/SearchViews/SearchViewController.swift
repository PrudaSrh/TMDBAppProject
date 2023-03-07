//
//  SearchViewController.swift
//  theMovieDBAppProject
//
//  Created by Serhii on 3/2/23.
//

import UIKit
import Alamofire
import SDWebImage

class SearchViewController: UIViewController {
    
    var searchMediaViewModel = SearchMediaViewModel()
    var moviesViewModel = TrendingMediaViewModel()
    
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var searchTypeSegmentControl: UISegmentedControl!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Register cell
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        self.searchTableView.register(nib, forCellReuseIdentifier: "SearchTableViewCell")
        searchField.searchTextField.textColor = UIColor.gray
    }
    
    @IBAction func typeSearchSegmentControlTapped(_ sender: Any) {
        searchField.text = nil
        searchMediaViewModel.searchResultsMedia = []
        searchTableView.reloadData()
        
        //        searchTableView.setContentOffset(.zero, animated: false)
        //        let selectedMediaType: MediaType = (searchTypeSegmentControl.selectedSegmentIndex == 0) ? .movie : .tv
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ searchTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.searchMediaViewModel.searchResultsMedia.count
        switch searchTypeSegmentControl.selectedSegmentIndex {
        case 0:

            SearchMediaViewModel.stateSegment = .movie
            self.searchMediaViewModel.searchResultsMedia.count
            
        case 1:
            SearchMediaViewModel.stateSegment = .tv
            return searchMediaViewModel.searchResultsMedia.count
            
        default:
            fatalError("segment controll error")
        }
        return searchMediaViewModel.searchResultsMedia.count
    }
    
    func tableView(_ searchTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        switch searchTypeSegmentControl.selectedSegmentIndex {
        case 0:
            cell.configure(with: searchMediaViewModel.searchResultsMedia[indexPath.row])
            
        case 1:
            cell.configure(with: searchMediaViewModel.searchResultsMedia[indexPath.row])
            
        default:
            fatalError("segment controll error")
        }
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchField: UISearchBar, textDidChange searchText: String) {
        if searchField.searchTextField.text?.count ?? 0 >= 2 {
            guard let query = searchField.text, !query.isEmpty else {
                return
            }
            switch searchTypeSegmentControl.selectedSegmentIndex {
            case 0:
                searchMediaType(query: query, mediaType: .movie) { results in
                    self.searchMediaViewModel.searchResultsMedia = results
                    self.searchTableView.reloadData()
                }
            case 1:
                searchMediaType(query: query, mediaType: .tv) { results in
                    self.searchMediaViewModel.searchResultsMedia = results
                    self.searchTableView.reloadData()
                }
            default:
                break
            }
        }
        
        func searchMediaType(query: String, mediaType: MediaType, completion: @escaping([SearchResultMedia]) -> ()) {
            switch mediaType {
            case .movie:
                searchMedia(query: query, mediaType: .movie) { results in
                    completion(results)
                }
            case .tv:
                searchMedia(query: query, mediaType: .tv) { results in
                    completion(results)
                }
            }
        }
        
        func searchMedia(query: String, mediaType: MediaType, completion: @escaping ([SearchResultMedia]) -> Void) {
            
            let baseURL = "https://api.themoviedb.org/3/search/"
            let mediaString: String
            switch mediaType {
            case .movie:
                mediaString = "movie"
            case .tv:
                mediaString = "tv"
            }
            let urlString = "\(baseURL)\(mediaString)?api_key=c7d6331c4f99dbf246f413e9e34ff5a3&language=en-US&query=\(query)"
            AF.request(urlString).responseDecodable(of: SearchResultMediaMulti.self) { response in
                guard let results = response.value?.results else {
                    return
                }
                completion(results)
            }
        }
    }
}

// MARK: - Push to detail screen
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        
        let selectedMedia = searchMediaViewModel.searchResultsMedia[indexPath.row]
        switch searchTypeSegmentControl.selectedSegmentIndex {
        case 0:
            viewController.movieDetailViewModel = MovieDetailViewModel(media: selectedMedia, test: true)
        case 1:
            viewController.movieDetailViewModel = MovieDetailViewModel(media: selectedMedia, test: false)
        default:
            break
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

