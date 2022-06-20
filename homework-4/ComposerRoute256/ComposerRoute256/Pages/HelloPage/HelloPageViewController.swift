import UIKit

class HelloPageViewController: UIViewController {
    let greetingLabel: UILabel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        greetingLabel.frame = view.frame
        greetingLabel.textAlignment = .center
        view.addSubview(greetingLabel)
    }
}
