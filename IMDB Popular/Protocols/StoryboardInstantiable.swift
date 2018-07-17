import UIKit

public protocol StoryboardInstantiable: class {
    static var storyboardName: String { get }
    static var identifier: String { get }
    static func instantiate() -> Self
}

public extension StoryboardInstantiable {
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    private static var storyboard: UIStoryboard {
        return UIStoryboard(name: Self.storyboardName, bundle: nil)
    }
    
    public static func instantiate() -> Self {
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("Could not instantiate \(Self.self) from storyboard file.")
        }
        configureVIPERModule(for: controller)
        
        return controller
    }
    
    private static func configureVIPERModule(for controller: Self) {
        let moduleConfiguratorClass = "\(moduleName)ModuleConfigurator"
        if let configuratorClass = moduleConfiguratorClass.swiftClassFromString() as? NSObject.Type {
            let configuratorClassObj = configuratorClass.init()
            let selector = NSSelectorFromString("configureModuleFor:")
            if configuratorClassObj.responds(to: selector) {
                configuratorClassObj.perform(selector, with: controller)
            }
        }
    }
    
    private static var moduleName: String {
        return Self.identifier.replacingOccurrences(of: "ViewController", with: "")
    }
}

private extension String {
    func swiftClassFromString() -> AnyClass? {
        if let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            let fAppName = appName.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
            return NSClassFromString("\(fAppName).\(self)")
        }
        return nil
    }
}
