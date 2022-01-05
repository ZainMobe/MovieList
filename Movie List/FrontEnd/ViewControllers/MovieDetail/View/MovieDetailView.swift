//
//  MovieDetailView.swift
//  Movie List
//
//  Created by Zain Haider on 05/01/2022.
//

import UIKit


class MovieDetailView: UIView {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var outletFavourite: UIButton!
    
    weak var controller: UIViewController?
    
    var imgBanner: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        imgPoster.layer.cornerRadius = imgPoster.frame.width/2
        imgBanner.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imgBanner.heightAnchor.constraint(equalToConstant: 32).isActive = true
        setBannerImage()
    }
    
    private func setBannerImage() {
        controller?.navigationItem.titleView = imgBanner
    }
    
    func setMovieData(_ model: Movie) {
        imgPoster.sd_setImage(with: model.getImageURL(), placeholderImage: UIImage(named: "DummyMovie"), options: .refreshCached)
        lblReleaseDate.text = model.title
        lblDetails.text = model.overview
        outletFavourite.setImage(model.isFavouriteMovie() ? UIImage(named: "heartFilled") : UIImage(named: "heartEmpty"), for: .normal)
        imgBanner.sd_setImage(with: model.getBannerImageURL()) {[weak self] _, _, _, _ in
            DispatchQueue.main.async {
                self?.setBannerImage()
            }
        }
    }
    
}
