//
//  SecondViewController.swift
//  myMemo
//
//  Created by Kyle on 2023/08/01.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
    }
    
    func setUp() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: .none)
        navigationItem.rightBarButtonItem = addButton
    }

    @IBAction func addButtonTapped(_ sender: Any) {
    }
    

}
