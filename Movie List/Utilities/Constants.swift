//
//  Constants.swift
//  Movie List
//
//  Created by Zain Haider on 05/01/2022.
//

import Foundation



struct AppCreds {
    static let apiKey = "e5ea3092880f4f3c25fbc537e9b37dc1"
}

struct ApiConstant {
    static let baseURL = "https://api.themoviedb.org/3/"
    
    static let movieList = "movie/popular"
    static let searchMovie = "search/movie"
    static let posterImage = "https://image.tmdb.org/t/p/w92"
}

struct cells {
    static let MovieCell = "MovieCell"
    static let FavouriteCell = "FavouriteCell"
}

struct userDefaultKeys {
    static let favourites = "favourites"
}

public struct enums {
    enum storyboard: String {
        case Main
    }
    
    enum vc_identifiers: String {
        case DashboardController
        case MovieDetailController
        case FavouritesController
    }
    
}
