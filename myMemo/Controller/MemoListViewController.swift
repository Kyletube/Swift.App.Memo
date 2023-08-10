import UIKit

class MemoListViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var memoManager = MemoManager.shared
    
    var filteredList: [(id: Int, memo: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "MemoCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }
    
    @objc func switchChanged(_ sender: UISwitch) {
        let index = sender.tag
        
        memoManager.updateSwitchState(at: sender.tag, isOn: sender.isOn)
        
        table.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        showAddMemoAlert { newMemo in
            self.memoManager.addMemo(newMemo)
            self.table.reloadData()
        }
    }
    
    func deleteMemo(at indexPath: IndexPath) {
        memoManager.deleteMemo(at: indexPath.row)
        table.reloadData()
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showDetail",
               let detailVC = segue.destination as? DetailViewController,
               let selectedIndexPath = sender as? IndexPath {
                let selectedRow = selectedIndexPath.row
                if searchBar.text?.isEmpty ?? true {
                    detailVC.memoIndex = selectedRow
                } else {
                    let selectedMemo = filteredList[selectedRow]
                    if let memoIndex = memoManager.getMemos().firstIndex(of: selectedMemo.memo) {
                        detailVC.memoIndex = memoIndex
                    }
                }
            }
        }
}

extension MemoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true // 셀을 스와이프 가능하게 함
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showDeleteAlert(at: indexPath) {
                self.deleteMemo(at: indexPath)
            }
        }
    }
}

extension MemoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchBar.text?.isEmpty ?? true ? memoManager.getMemos().count : filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath)
        
        let memoIndex: Int
        if searchBar.text?.isEmpty ?? true {
            memoIndex = indexPath.row
        } else {
            let selectedMemoTuple = filteredList[indexPath.row]
            memoIndex = selectedMemoTuple.id
        }
        
        let text = memoManager.getMemos()[memoIndex]
        let isSwitchOn = memoManager.getSwitchStates()[memoIndex]
        
        let switchView = UISwitch(frame: .zero)
        switchView.tag = memoIndex // indexPath.row 대신 memoIndex를 사용
        switchView.isOn = isSwitchOn
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        
        // 스위치 상태에 따라 셀 텍스트 스타일 설정
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        if isSwitchOn {
            attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        } else {
            attributeString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
        }
        cell.textLabel?.attributedText = attributeString
        
        return cell
    }
    
}

extension MemoListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredList = memoManager.getMemos().enumerated().filter { index, memo in
            return memo.localizedCaseInsensitiveContains(searchText)
        }.map { index, memo in
            return (index, memo)
        }
        table.reloadData()
    }
}

