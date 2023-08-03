import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var table: UITableView!
    var memoList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            loadMemos()
            table.reloadData()
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath)
        cell.textLabel?.text = memoList[indexPath.row]
        return cell
    }

    func setUp() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped(_:)))
        navigationItem.rightBarButtonItem = addButton

        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "MemoCell")
        
        loadMemos()
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        let newMemo = "새로운 메모"
        memoList.append(newMemo)
        saveMemos()
        table.reloadData()
    }

    
    func saveMemos() {
        UserDefaults.standard.set(memoList, forKey: "Memos")
    }

    
    func loadMemos() {
        if let memos = UserDefaults.standard.array(forKey: "Memos") as? [String] {
            memoList = memos
        }
    }
    
    func deleteMemo(at indexPath: IndexPath) {
        memoList.remove(at: indexPath.row)
        saveMemos()
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true // 셀을 스와이프 가능하게 함
        }

        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                showDeleteAlert(at: indexPath)
            }
        }
    
    func showDeleteAlert(at indexPath: IndexPath) {
            let alertController = UIAlertController(title: "메모 삭제", message: "선택한 메모를 삭제하시겠습니까?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { (_) in
                self.deleteMemo(at: indexPath)
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
           let detailVC = segue.destination as? DetailViewController,
           let selectedIndexPath = sender as? IndexPath {
                   let selectedRow = selectedIndexPath.row
                   detailVC.memo = memoList[selectedRow]
               }
           }
}
