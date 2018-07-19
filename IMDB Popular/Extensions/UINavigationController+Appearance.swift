import UIKit

extension UINavigationController {
    
    func setAppearance() {
        self.navigationBar.barTintColor = UIColor.appOrange
        self.navigationBar.tintColor = UIColor.white
        
        let lightAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationBar.titleTextAttributes = lightAttributes
        if #available(iOS 11.0, *) {
            navigationBar.largeTitleTextAttributes = lightAttributes
        }
    }
}
