import UIKit

class DetailViewController: UIViewController {

    var memo: String?

    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var detailDeleteButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        memoTextView.text = memo
    }
    
    
    
    @IBAction func detailDeleteMemo(_ sender: UIBarButtonItem) {
        deleteMemo()
    }
    
    func deleteMemo() {
        guard let memoToDelete = memo else { return }

        if var memos = UserDefaults.standard.array(forKey: "Memos") as? [String],
           let index = memos.firstIndex(of: memoToDelete) {
            memos.remove(at: index)
            UserDefaults.standard.set(memos, forKey: "Memos")
            navigationController?.popViewController(animated: true)
        }
    }
}
