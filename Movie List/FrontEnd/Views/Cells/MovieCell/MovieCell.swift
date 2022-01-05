//
//  MovieCell.swift
//  Movie List
//
//  Created by Zain Haider on 05/01/2022.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var outletFavourite: UIButton!
    
    var toggleFavourite: (()-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        setup()
    }
    
    override func draw(_ rect: CGRect) {
        setup()
    }
    
    private func setup() {
        imgPoster.roundCorners(corners: [.topLeft, .topRight], radius: 16)
    }

    func setup(_ model: Movie?) {
        lblMovieTitle.text = model?.title
        lblReleaseDate.text = model?.release_date
        imgPoster.sd_setImage(with: model?.getImageURL(), placeholderImage: UIImage(named: "DummyMovie"), options: .refreshCached)
        outletFavourite.setImage((model?.isFavouriteMovie() == true) ? UIImage(named: "heartFilled") : UIImage(named: "heartEmpty"), for: .normal)
    }
    
    @IBAction func actionFavourite(_ sender: UIButton) {
        toggleFavourite?()
    }
}
