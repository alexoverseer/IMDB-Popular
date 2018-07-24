import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
        let red = interval(0, red, 255)
        let green = interval(0, green, 255)
        let blue = interval(0, blue, 255)
        let alpha = interval(0, alpha, 1)
        
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
    }
    
    static var appOrange: UIColor {
        return UIColor(red: 245, green: 197, blue: 24)
    }
}
