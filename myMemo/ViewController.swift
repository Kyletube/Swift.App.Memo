import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var completeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    func makeUI() {
        checkButton.clipsToBounds = true
        checkButton.layer.cornerRadius = 5
        
        completeButton.clipsToBounds = true
        completeButton.layer.cornerRadius = 5
        
        mainImageView.image = UIImage(named: "MemoImage")
        
    }
}

