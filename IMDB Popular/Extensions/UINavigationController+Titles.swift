import Foundation
import UIKit

extension UINavigationController {
    
    func setOnLargeTitle() {
        navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    func setOffLargeTitle() {
        navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
}
