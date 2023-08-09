import UIKit

class CompleteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var memoManager = MemoManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }
}

extension CompleteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoManager.getCompletedMemos().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteMemoCell", for: indexPath)
        
        let completedMemos = memoManager.getCompletedMemos()
        cell.textLabel?.text = completedMemos[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true // 셀을 스와이프 가능하게 함
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                showDeleteAlert(at: indexPath) {
                    self.memoManager.deleteMemo(at: indexPath.row)
                    tableView.reloadData()
                }
            }
        }
    }
