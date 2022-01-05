//
//  FavouritesController.swift
//  Movie List
//
//  Created by Zain Haider on 05/01/2022.
//

import UIKit

class FavouritesController: BaseViewController {

    @IBOutlet weak var favouritesView: FavouritesView!
    
    var favourites: [Movie] = []
    var favouritesViewModel = FavouritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    deinit {
        print("Releasing FavouritesController")
    }
    
    private func setup() {
        reloadData()
    }
    
    private func reloadData() {
        favouritesView.tableView.isHidden = favourites.count < 1
        favouritesView.tableView.reloadData()
    }


}

extension FavouritesController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        176
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cells.FavouriteCell, for: indexPath) as? FavouriteCell else {return UITableViewCell()}
        let movie = favourites[indexPath.row]
        cell.setup(movie)
        cell.removeFavourite = {[weak self] in
            self?.favourites.remove(at: indexPath.row)
            self?.favouritesViewModel.removeFavourite(movie.id!)
            DispatchQueue.main.async {
                self?.reloadData()
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
}
