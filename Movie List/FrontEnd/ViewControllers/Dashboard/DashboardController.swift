//
//  ViewController.swift
//  Movie List
//
//  Created by Zain Haider on 05/01/2022.
//

import UIKit

class DashboardController: BaseViewController {

    @IBOutlet weak var dashboardView: DashboardView!
        
    var dashboardViewModel: DashboardViewModel!
    var fetching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dashboardView.collectionView.reloadData()
    }
    
    fileprivate func setup() {
        registerCell()
        dashboardViewModel = DashboardViewModel()
        dashboardView.collectionView.delegate = self
        dashboardView.collectionView.reloadData()
        getMovies()
        let favouriteAction = UIBarButtonItem(image: UIImage(named: "favourites"), style: .plain, target: self, action: #selector(self.favouriteTapped))
        let searchAction = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(self.searchTapped))
        navigationItem.rightBarButtonItems = [searchAction, favouriteAction]
    }
    
    private func registerCell() {
        let nib = UINib(nibName: cells.MovieCell, bundle: nil)
        dashboardView.collectionView.register(nib, forCellWithReuseIdentifier: cells.MovieCell)
    }
    
    @objc private func favouriteTapped() {
        let vc = getController(identifier: .FavouritesController) as! FavouritesController
        vc.favourites = dashboardViewModel.getFavourites()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func searchTapped() {
        
    }
    
    func getMovies(loadNextPage: Bool = false) {
        guard fetching == false else {return}
        fetching = true
        if !loadNextPage {
            dashboardView.activityView.startAnimating()
        }
        print("Requesting new data....")
        dashboardViewModel.getMovieList(loadNextPage: loadNextPage) {[unowned self] in
            DispatchQueue.main.async {
                self.fetching = false
                self.dashboardView.collectionView.reloadData()
                self.dashboardView.activityView.stopAnimating()
            }
        } onFailure: {[unowned self] error in
            DispatchQueue.main.async {
                self.fetching = false
                self.dashboardView.collectionView.reloadData()
                self.dashboardView.activityView.stopAnimating()
                self.alert(message: error)
            }
        }
    }

}

extension DashboardController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dashboardViewModel.getMovies()?.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cells.MovieCell, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        let model = dashboardViewModel.getMovies()?.movies?[indexPath.item]
        cell.setup(model)
        cell.toggleFavourite = {[weak self] in
            guard let id = model?.id else {return}
            if model!.isFavouriteMovie() {
                self?.dashboardViewModel.removeFavourite(id)
            } else {
                self?.dashboardViewModel.addFavourite(id)
            }
            DispatchQueue.main.async {
                collectionView.reloadItems(at: [indexPath])
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let previousList = dashboardViewModel.getMovies()?.movies?.count ?? 0
        if indexPath.item == previousList - 1 {
            if (dashboardViewModel.getMovies()?.total_results ?? 0) > previousList {
                self.getMovies(loadNextPage: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = dashboardViewModel.getMovies()?.movies?[indexPath.item],
        let id = movie.id else {return}
        DispatchQueue.main.async {
            let vc = self.getController(identifier: .MovieDetailController) as! MovieDetailController
            vc.movie = movie
            vc.toggleFavourite = {[unowned self] in
                movie.isFavouriteMovie() ? self.dashboardViewModel.removeFavourite(id) : self.dashboardViewModel.addFavourite(id)
                DispatchQueue.main.async {
                    collectionView.reloadItems(at: [indexPath])
                }
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

extension DashboardController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width / 2 - 8
        let height = width + 80
        return CGSize(width: width, height: height)
    }
}
