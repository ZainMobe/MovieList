//
//  ViewModel.swift
//  Movie List
//
//  Created by Zain Haider on 05/01/2022.
//

import UIKit


class DashboardViewModel: BaseViewModel {
        
    private var moviesModel: MoviesModel?
    
    func getMovieList(loadNextPage: Bool, onSuccess: @escaping (()->Void), onFailure: @escaping (_ error: String) -> Void) {
        
        let currentPage = moviesModel?.page ?? 0
        let totalPages = moviesModel?.total_pages ?? 0
        
        let nextPage = (loadNextPage && (totalPages > currentPage)) ? currentPage + 1 : 1
        if !loadNextPage {
            self.moviesModel?.movies?.removeAll()
        }
        
        let params = [
            "api_key": AppCreds.apiKey,
            "page": nextPage
        ] as [String : Any]
        
        LogsManager.shared.logAPI(type: .beforeHittingAPI, url: ApiConstant.movieList, params: params)
        self.callApi(targe: .getMovieList(params: params), onSuccess: { (model: MoviesModel) in
            var allMovies = self.moviesModel?.movies ?? []
            let newMovies = model.movies ?? []
            
            if nextPage == 1 {
                self.moviesModel = model
            } else {
                allMovies += newMovies
                self.moviesModel = model
                self.moviesModel?.movies = allMovies
            }
            MoviesDB.shared.setMoviesData(model: self.moviesModel!)
            onSuccess()
        }, onFailure: onFailure)
    }
    
    private func loadMoviesFromLocalDB() {
        self.moviesModel = MoviesDB.shared.getMoviesData()
    }
    
    func getFavourites() -> [Movie] {
        let favourites = UserDefaults.standard.array(forKey: userDefaultKeys.favourites) as? [Int] ?? []
        let movies = self.moviesModel?.movies?.filter({favourites.contains($0.id ?? 0)}) ?? []
        return movies
    }
    
    func removeFavourite(_ movieId: Int) {
        var favourites = UserDefaults.standard.array(forKey: userDefaultKeys.favourites) as? [Int] ?? []
        favourites.removeAll(where: {$0 == movieId})
        UserDefaults.standard.setValue(favourites, forKey: userDefaultKeys.favourites)
    }
    
    func addFavourite(_ movieId: Int) {
        var favourites = UserDefaults.standard.array(forKey: userDefaultKeys.favourites) as? [Int] ?? []
        favourites.removeAll(where: {$0 == movieId})
        favourites.append(movieId)
        UserDefaults.standard.setValue(favourites, forKey: userDefaultKeys.favourites)
    }
    
    func getMovies() -> MoviesModel? {
        return moviesModel
    }
    
}
