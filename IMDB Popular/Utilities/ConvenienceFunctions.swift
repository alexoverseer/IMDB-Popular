import UIKit

let isPad: Bool = {
    return UIDevice.current.userInterfaceIdiom == .pad
}()

let isPhone: Bool = {
    return UIDevice.current.userInterfaceIdiom == .phone
}()

func interval<T: Comparable>(_ minimum: T, _ num: T, _ maximum: T) -> T {
    return min(maximum, max(minimum, num))
}
