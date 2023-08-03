import UIKit

class MemoManager {
    static let shared = MemoManager()
        
    private var memoList = [String]()
    
    init() {
        loadMemos()
    }
    
    func getMemos() -> [String] {
        return memoList
    }
    
    func addMemo(_ memo: String) {
        memoList.append(memo)
        saveMemos()
    }
    
    func deleteMemo(at index: Int) {
        guard index >= 0, index < memoList.count else { return }
        memoList.remove(at: index)
        saveMemos()
    }
    
    private func saveMemos() {
        UserDefaults.standard.set(memoList, forKey: "Memos")
    }
    
    private func loadMemos() {
        if let memos = UserDefaults.standard.array(forKey: "Memos") as? [String] {
            memoList = memos
        }
    }
}
