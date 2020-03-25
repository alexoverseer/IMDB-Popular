import UIKit

extension UIColor {
    
    convenience private init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
        let red = interval(0, red, 255)
        let green = interval(0, green, 255)
        let blue = interval(0, blue, 255)
        let alpha = interval(0, alpha, 1)
        
        self.init(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: alpha
        )
    }

    static private func dynamic(light: UIColor, dark: UIColor) -> UIColor {

        if #available(iOS 13.0, *) {
            return UIColor(dynamicProvider: {
                switch $0.userInterfaceStyle {
                case .dark:
                    return dark
                case .light, .unspecified:
                    return light
                @unknown default:
                    assertionFailure("Unknown userInterfaceStyle: \($0.userInterfaceStyle)")
                    return light
                }
            })
        }

        return light
    }
    
    static let appOrange = UIColor.dynamic(
        light: UIColor(red: 243, green: 153, blue: 56),
        dark: UIColor(red: 243, green: 162, blue: 60)
    )
    
    static let appBlack = UIColor.dynamic(
        light: .black,
        dark: .white
    )
}
