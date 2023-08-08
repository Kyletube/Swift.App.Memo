import UIKit

class MemoListViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBOutlet weak var table: UITableView!
    
    var memoManager = MemoManager.shared
    
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
        let isOn = sender.isOn
        memoManager.updateSwitchState(at: index, isOn: isOn) // 스위치 상태를 업데이트하고 저장
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
            detailVC.memoIndex = selectedRow // memo 대신 memoIndex에 인덱스 값을 넘겨줌
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
        return memoManager.getMemos().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath)
        let text = memoManager.getMemos()[indexPath.row]
        
        let switchView = UISwitch(frame: .zero)
        switchView.tag = indexPath.row
        switchView.isOn = memoManager.getSwitchStates()[indexPath.row] // 스위치 상태 설정
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        
        // 스위치 상태에 따라 셀 텍스트 스타일 설정
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        if switchView.isOn {
            attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        }
        cell.textLabel?.attributedText = attributeString
        
        return cell
    }
}


//    private func loadSwitchStates() {
//        let switchStates = memoManager.getSwitchStates()
//        for (index, isOn) in switchStates.enumerated() {
//            if isOn {
//                let indexPath = IndexPath(row: index, section: 0)
//                table.reloadRows(at: [indexPath], with: .automatic)
//            }
//        }
//    }
//        loadSwitchStates()