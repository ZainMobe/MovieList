//
//  BaseViewController.swift
//  Movie List
//
//  Created by Zain Haider on 05/01/2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    /// Push Controller in current navigation stack
    /// - Parameters:
    ///   - storyboard_name: Storyboard name in which contains controller in String formate.
    ///   - vc_identifier: ID of the controller in String formate.
    func push(storyboard: enums.storyboard = .Main, identifier: enums.vc_identifiers) {
        let vc = self.getController(storyboard: storyboard, identifier: identifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// Get controller from storyboard.
    /// - Parameters:
    ///   - storyboard_name: Storyboard name in which contains controller in String formate.
    ///   - vc_identifier: ID of the controller in String formate.
    /// - Returns: UIViewController
    func getController(storyboard: enums.storyboard = .Main, identifier: enums.vc_identifiers) -> UIViewController{
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier.rawValue)
        return vc
    }
}
