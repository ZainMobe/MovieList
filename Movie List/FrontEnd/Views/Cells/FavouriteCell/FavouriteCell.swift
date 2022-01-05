//
//  FavouriteCell.swift
//  Movie List
//
//  Created by Zain Haider on 05/01/2022.
//

import UIKit

class FavouriteCell: UITableViewCell {

    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOverView: UILabel!
    
    var removeFavourite: (()-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(_ model: Movie) {
        lblTitle.text = model.title
        lblOverView.text = model.overview
        imgPoster.sd_setImage(with: model.getImageURL(), placeholderImage: UIImage(named: "DummyMovie"), options: .refreshCached)
    }

    @IBAction func actionFavourite(_ sender: UIButton) {
        removeFavourite?()
    }
    
}
