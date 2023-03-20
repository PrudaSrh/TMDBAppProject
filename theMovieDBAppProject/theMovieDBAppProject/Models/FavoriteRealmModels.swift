//
//  FavoriteRealmModels.swift
//  theMovieDBAppProject
//
//  Created by Serhii on 3/5/23.
//

import Foundation
import RealmSwift

class MovieRealm: Object {
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String?
    @Persisted var backdropPath: String?
    @Persisted var overview: String
    @Persisted var posterPath: String?
    @Persisted var voteAverage: Double
    @Persisted var originalTitle: String

}

class TVRealm: Object {
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String?
    @Persisted var backdropPath: String?
    @Persisted var overview: String
    @Persisted var posterPath: String?
    @Persisted var voteAverage: Double
    @Persisted var originalName: String

}
