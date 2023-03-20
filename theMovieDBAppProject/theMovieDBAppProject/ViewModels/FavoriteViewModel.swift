//
//  FavoriteViewModel.swift
//  theMovieDBAppProject
//
//  Created by Serhii on 3/5/23.
//

import Foundation
import RealmSwift


class FavoriteViewModel {
    
    var movies: [MovieRealm] = []
    
    var tvShows: [TVRealm] = []

    // MARK: - Get all movies from Realm database
    func getMovie() {
        movies = MovieDataManager.shared.getMovie()
      }
    
    // MARK: - Delete a movie from the Realm database
    func deleteMovie(movie: MovieRealm) {
        MovieDataManager.shared.deleteMovie(movie: movie)
      }
    func getTVShow() {
        tvShows = MovieDataManager.shared.getTVShow()
      }
    
    // MARK: - Delete a tvShow from the Realm database
    func deleteTVShow(tvShow: TVRealm) {
        MovieDataManager.shared.deleteTVShow(tvShow: tvShow)
      }
    
}
