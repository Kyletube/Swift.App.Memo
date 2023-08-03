import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var table: UITableView!
    var memoManager = MemoManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            table.reloadData()
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoManager.getMemos().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath)
        cell.textLabel?.text = memoManager.getMemos()[indexPath.row]
        return cell
    }

    func setUp() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped(_:)))
        navigationItem.rightBarButtonItem = addButton

        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "MemoCell")
        
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        let newMemo = "새로운 메모"
        memoManager.addMemo(newMemo)
        table.reloadData()
    }
    
    func deleteMemo(at indexPath: IndexPath) {
        memoManager.deleteMemo(at: indexPath.row)
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
            detailVC.memo = memoManager.getMemos()[selectedRow]
               }
           }
}
