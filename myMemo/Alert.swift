import UIKit

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
