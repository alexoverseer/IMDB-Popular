import UIKit

extension UINavigationController {
    
    func setAppearance() {
        self.navigationBar.tintColor = UIColor.appOrange
        
        let blackAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appBlack]
        navigationBar.titleTextAttributes = blackAttributes
        navigationBar.largeTitleTextAttributes = blackAttributes
    }
}
