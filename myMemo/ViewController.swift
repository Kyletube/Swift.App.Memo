//
//  ViewController.swift
//  myMemo
//
//  Created by Kyle on 2023/07/31.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstViewImage: UIImageView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }

    func makeUI() {
        checkButton.clipsToBounds = true
        checkButton.layer.cornerRadius = 5
        checkButton.backgroundColor = .white
        checkButton.setTitle("할 일 확인하기", for: .normal)
        
        completeButton.clipsToBounds = true
        completeButton.layer.cornerRadius = 5
        completeButton.backgroundColor = .white
        completeButton.setTitle("완료한 일 보기", for: .normal)
        
        mainImageView.image = UIImage(named: "메모이미지")
        
    }
    @IBAction func checkButtonTapped(_ sender: Any) {
    }
    
    @IBAction func completeButtonTapped(_ sender: Any) {
    }
}

