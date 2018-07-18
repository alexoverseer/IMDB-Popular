import Foundation
import UIKit

extension UINavigationController {
    
    func setOnLargeTitle() {
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
        }
    }
    
    func setOffLargeTitle() {
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = false
            navigationItem.largeTitleDisplayMode = .never
        }
    }
}
