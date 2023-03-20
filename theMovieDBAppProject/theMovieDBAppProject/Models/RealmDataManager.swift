//
//  RealmDataManager.swift
//  theMovieDBAppProject
//
//  Created by Serhii on 3/9/23.
//

import Foundation
import RealmSwift

// MARK: - Movie Data Manager

struct MovieDataManager {

    static let shared = MovieDataManager()
    public let realm = try? Realm()
    private init() {}

    // MARK: - MovieDataManager Functions

    func saveMovie(movie: Movie?) {
        let movieRealm = MovieRealm()

        movieRealm.id = movie?.id ?? 0
        movieRealm.title = movie?.title ?? ""
        movieRealm.originalTitle = movie?.originalTitle ?? ""
        movieRealm.posterPath = movie?.backdropPath ?? ""
        movieRealm.overview = movie?.overview ?? ""
        movieRealm.voteAverage = movie?.voteAverage ?? 0

        try? realm?.write {
            realm?.add(movieRealm, update: .all)
        }
    }
    
    // MARK: - tvShowDataManager Functions

    func saveMovie(tvShow: TVShows?) {
        let tvRealm = TVRealm()

        tvRealm.id = tvShow?.id ?? 0
        tvRealm.name = tvShow?.name ?? ""
        tvRealm.originalName = tvShow?.originalName ?? ""
        tvRealm.posterPath = tvShow?.backdropPath ?? ""
        tvRealm.overview = tvShow?.overview ?? ""
        tvRealm.voteAverage = tvShow?.voteAverage ?? 0

        try? realm?.write {
            realm?.add(tvRealm, update: .all)
        }
    }

    func getMovie() -> [MovieRealm] {
        var movies = [MovieRealm]()
        guard let movieResult = realm?.objects(MovieRealm.self) else { return [] }
        for movie in movieResult {
            movies.append(movie)
        }
        return movies
    }

    func getMovieToRealm(movie: Movie) -> MovieRealm {
        guard let movieRealm = realm?.object(ofType: MovieRealm.self, forPrimaryKey: movie.id) else { return MovieRealm() }
        return movieRealm
    }
    
    func deleteMovie(movie: MovieRealm) {
        try? realm?.write {
            realm?.delete(movie)
        }
    }
    
    func getTVShow() -> [TVRealm] {
        var tvShows = [TVRealm]()
        guard let tvShowResult = realm?.objects(TVRealm.self) else { return [] }
        for tvShow in tvShowResult {
            tvShows.append(tvShow)
        }
        return tvShows
    }

    func getTVShowToRealm(tvShow: TVShows) -> TVRealm {
        guard let tvShowRealm = realm?.object(ofType: TVRealm.self, forPrimaryKey: tvShow.id) else { return TVRealm() }
        return tvShowRealm
    }
    
    func deleteTVShow(tvShow: TVRealm) {
        try? realm?.write {
            realm?.delete(tvShow)
        }
    }
}
