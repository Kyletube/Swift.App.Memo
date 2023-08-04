import UIKit

class MemoManager {
    static let shared = MemoManager()

    private var memoList = [String]()
    private var switchStates = [Bool]()

    private init() {
        loadMemos()
        loadSwitchStates()
    }

    func getMemos() -> [String] {
        return memoList
    }

    func getSwitchStates() -> [Bool] {
        return switchStates
    }

    func addMemo(_ memo: String) {
        memoList.append(memo)
        switchStates.append(false)
        saveMemos()
        saveSwitchStates()
    }

    func deleteMemo(at index: Int) {
        guard index >= 0, index < memoList.count else { return }
        memoList.remove(at: index)
        switchStates.remove(at: index)
        saveMemos()
        saveSwitchStates()
    }
    
    private func saveMemos() {
        UserDefaults.standard.set(memoList, forKey: "Memos")
    }

    private func loadMemos() {
        if let memos = UserDefaults.standard.array(forKey: "Memos") as? [String] {
            memoList = memos
        }
    }

    func updateMemo(at index: Int, with memo: String) {
        guard index >= 0, index < memoList.count else { return }
        memoList[index] = memo
        saveMemos()
    }

    func updateSwitchState(at index: Int, isOn: Bool) {
        guard index >= 0, index < switchStates.count else { return }
        switchStates[index] = isOn
        saveSwitchStates()
    }
    
    private func saveSwitchStates() {
        UserDefaults.standard.set(switchStates, forKey: "SwitchStates")
    }

    private func loadSwitchStates() {
        if let switchStates = UserDefaults.standard.array(forKey: "SwitchStates") as? [Bool] {
            self.switchStates = switchStates
        } else {
            switchStates = Array(repeating: false, count: memoList.count)
            saveSwitchStates()
        }
    }
    
    func getCompletedMemos() -> [String] {
            var completedMemos = [String]()
            let switchStates = getSwitchStates()

            for (index, isOn) in switchStates.enumerated() {
                if isOn {
                    completedMemos.append(memoList[index])
                }
            }

            return completedMemos
        }
}
