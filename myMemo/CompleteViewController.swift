import UIKit

class CompleteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var memoManager = MemoManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension CompleteViewController: UITableViewDelegate {
    
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
}
