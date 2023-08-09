import UIKit

class CompleteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var completeSearchBar: UISearchBar!
    
    var memoManager = MemoManager.shared
    var filteredCompleteMemos = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }
}

extension CompleteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completeSearchBar.text?.isEmpty ?? true ? memoManager.getCompletedMemos().count : filteredCompleteMemos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteMemoCell", for: indexPath)
        let completedMemos = memoManager.getCompletedMemos()
        let text = completeSearchBar.text?.isEmpty ?? true ? completedMemos[indexPath.row] : filteredCompleteMemos[indexPath.row]
        cell.textLabel?.text = text
        
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

extension CompleteViewController: UISearchBarDelegate {
    //서치바의 텍스트가 변경될때마다 호출됨
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCompleteMemos = memoManager.getCompletedMemos().filter { memo in
            return memo.localizedCaseInsensitiveContains(searchText)
        } // 검색 바에 입력된 텍스트 (searchText)가 포함되어 있는지를 대소문자를 구분하지 않고 검사
        tableView.reloadData()
    }
}
