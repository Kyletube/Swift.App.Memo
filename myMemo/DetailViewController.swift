import UIKit

class DetailViewController: UIViewController {
    
    var memoIndex: Int?
    var memoManager = MemoManager.shared
    
    @IBOutlet weak var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        if let index = memoIndex {
            memoTextView.text = memoManager.getMemos()[index]
        }
        memoTextView.isEditable = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let editedMemo = memoTextView.text, let index = memoIndex {
            memoManager.updateMemo(at: index, with: editedMemo)
        }
    }
}
