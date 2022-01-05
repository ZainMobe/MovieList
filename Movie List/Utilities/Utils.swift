//
//  Utils.swift
//  Movie List
//
//  Created by Zain Haider on 05/01/2022.
//

import UIKit


class Utils {
    
    static func getRootController() -> UIViewController? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        let controller = delegate?.window?.rootViewController
        return controller
    }
    
    static func getAppDelegate() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        Self.getAppDelegate()?.orientationLock = orientation
    }
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
    
}
// MARK - Model Paths
extension Utils {
    //Nfix - use some good naming conventions for path functions these names are ambiguous
    static func moviesDataPath() -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let path = documentsPath?.appending("/Movies")
        return path!
    }

}
