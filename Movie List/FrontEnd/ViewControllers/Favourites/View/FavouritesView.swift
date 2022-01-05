//
//  FavouritesView.swift
//  Movie List
//
//  Created by Zain Haider on 05/01/2022.
//

import UIKit

class FavouritesView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        tableView.tableFooterView = UIView()
    }
    
}
