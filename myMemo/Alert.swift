import UIKit

// 메모 삭제 얼럿
extension UIViewController {
    func showDeleteAlert(at indexPath: IndexPath, deleteHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "메모 삭제", message: "선택한 메모를 삭제하시겠습니까?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { (_) in
            deleteHandler()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

// 메모 등록 얼럿
extension UIViewController {
    func showAddMemoAlert(completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: "새로운 메모", message: "메모 내용을 입력하세요.", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "할 일을 입력하세요."
        }
        
        let addAction = UIAlertAction(title: "등록", style: .default) { (_) in
            if let newMemo = alertController.textFields?.first?.text {
                completion(newMemo)
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
