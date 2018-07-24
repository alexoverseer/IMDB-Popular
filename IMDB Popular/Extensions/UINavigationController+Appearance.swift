import UIKit

extension UINavigationController {
    
    func setAppearance() {
        self.navigationBar.barTintColor = UIColor.appOrange
        self.navigationBar.tintColor = UIColor.black
        
        let blackAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        navigationBar.titleTextAttributes = blackAttributes
        if #available(iOS 11.0, *) {
            navigationBar.largeTitleTextAttributes = blackAttributes
        }
    }
}
