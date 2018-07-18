import UIKit

extension UIView {
    
    func addShadow(radius: CGFloat = 4, offset: CGSize = .zero,
                   opacity: Float = 0.1, color: UIColor = .black) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
}
