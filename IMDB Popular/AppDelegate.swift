import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        
        return true
    }
    
    private func setupWindow() {
        let controller = MovieListViewController.instantiate()
        MovieListModuleConfigurator().configureModule(for: controller)
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.setOnLargeTitle()
        navigationController.setAppearance()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
