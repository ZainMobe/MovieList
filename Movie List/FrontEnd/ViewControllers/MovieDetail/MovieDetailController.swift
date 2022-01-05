//
//  MovieDetailController.swift
//  Movie List
//
//  Created by Zain Haider on 05/01/2022.
//

import UIKit

class MovieDetailController: UIViewController {

    @IBOutlet weak var movieDetailView: MovieDetailView!
    
    var toggleFavourite: (()-> Void)?
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Utils.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    deinit {
        print("Releasing MovieDetailController")
    }

    fileprivate func setup() {
        movieDetailView.controller = self
        Utils.lockOrientation(.all)
        movieDetailView.setMovieData(movie)
    }

    @IBAction func actionFavourite(_ sender: Any) {
        toggleFavourite?()
        movieDetailView.setMovieData(movie)
    }
}
