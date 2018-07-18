import UIKit

final class MovieDetailViewController: UIViewController, StoryboardInstantiable {
	static var storyboardName: String = "MovieDetailViewController"
    var output: MovieDetailViewOutput!

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewIsReady()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParentViewController {
            output.isClosingCurrentController()
        }
    }
}

// MARK: - MovieDetailViewInput

extension MovieDetailViewController: MovieDetailViewInput {
    
    func setupInitialState() {

    }
}
