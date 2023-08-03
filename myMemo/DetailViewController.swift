import UIKit

class DetailViewController: UIViewController {

    var memo: String?
    var memoManager = MemoManager.shared

    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var detailDeleteButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        memoTextView.text = memo
        memoTextView.isEditable = true
        
    }
    
    
    
    @IBAction func detailDeleteMemo(_ sender: UIBarButtonItem) {
        deleteMemo()
    }
    
    func deleteMemo() {
        guard let memoToDelete = memo else { return }
        
        if let index = memoManager.getMemos().firstIndex(of: memoToDelete) {
            memoManager.deleteMemo(at: index)
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

            if let editedMemo = memoTextView.text {
                if let index = memoManager.getMemos().firstIndex(of: memo!) {
                    memoManager.updateMemo(at: index, with: editedMemo)
                }
            }
        }
}
