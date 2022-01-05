//
//  FavouritesViewModel.swift
//  Movie List
//
//  Created by Zain Haider on 05/01/2022.
//

import Foundation


class FavouritesViewModel {
    func removeFavourite(_ movieId: Int) {
        var favourites = UserDefaults.standard.array(forKey: userDefaultKeys.favourites) as? [Int] ?? []
        favourites.removeAll(where: {$0 == movieId})
        UserDefaults.standard.setValue(favourites, forKey: userDefaultKeys.favourites)
    }
    
}
