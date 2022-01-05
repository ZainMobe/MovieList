//
//  MoviesDB.swift
//  Movie List
//
//  Created by Zain Haider on 05/01/2022.
//

import Foundation


class MoviesDB: NSObject {
    /// User Data has values when login Api's hits.
    private var moviesData: MoviesModel?
    
    static let shared = MoviesDB()
    private override init() {
    }
    // MARK: - Set a model
    /**
     It will set Movies Data into the model.
     - Parameter model: Data model having primiry information of movies.
     - Returns: Nothing
     */
    func setMoviesData(model: MoviesModel) {
        self.moviesData=model
        self.writeMoviesDataModel()
    }
    // MARK: - Return a model
    /**
     It will use to Pick UserData from its Model for further use.
     - Returns: MoviesModel
     */
    func getMoviesData() -> MoviesModel? {
        return self.moviesData
    }
    // MARK: - Archive model to file
    func writeMoviesDataModel() {
        /// Archive model to file
        let encoder = JSONEncoder()
        guard let model = moviesData else {return}
        do {
            let encoded =  try encoder.encode(model)
            NSKeyedArchiver.archiveRootObject(encoded, toFile: Utils.moviesDataPath())
            print("Movies saved to local DB")
        } catch (let error) {
            print(error)
        }
    }
    // MARK: - Retuen User model
    func readMoviesDataModel() {
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: Utils.moviesDataPath()) as? Data else {return}
        let decoder = JSONDecoder()
        do {
            let userModelObject = try decoder.decode(MoviesModel.self, from: data)
            self.setMoviesData(model: userModelObject)
            print("Movies read from local DB")
        } catch (let error) {
            print(error)
        }
    }
    
    func removeMoviesData() {
        self.moviesData = nil
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: Utils.moviesDataPath())
        } catch (let error){
            print("Could not clear temp folder: \(error.localizedDescription)")
        }
    }
    
}
