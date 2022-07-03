//
//  ViewController.swift
//  myNews
//
//  Created by Pu Yue - PU YUE on 2022/06/26.
//

import UIKit

protocol SwipeDelegate {
    func changeMenuTo(_ index: Int)
}

class ViewController: UIViewController {
    @IBOutlet weak var leftView: UIStackView!
    @IBOutlet weak var rightView: UIStackView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var letfLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    var pageViewControllerObject: PageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftView.isUserInteractionEnabled = true
        let clickLeft = UITapGestureRecognizer.init(target: self, action: #selector(clickLeft))
        leftView.addGestureRecognizer(clickLeft)
        rightView.isUserInteractionEnabled = true
        let clickRight = UITapGestureRecognizer.init(target: self, action: #selector(clickRight))
        rightView.addGestureRecognizer(clickRight)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get PageViewController object
        if let vc = segue.destination as? PageViewController {
            self.pageViewControllerObject = vc
            vc.swipeDelegate = self
        }
    }
    
    @objc func clickLeft() {
        guard let pageViewControllerObject = pageViewControllerObject else { return }
        pageViewControllerObject.movePageTo(0)
        changeUI(0)
    }
    
    @objc func clickRight() {
        guard let pageViewControllerObject = pageViewControllerObject else { return }
        pageViewControllerObject.movePageTo(1)
        changeUI(1)
    }
    
    func changeUI(_ index: Int) {
        switch index {
        case 0:
            leftImageView.image = UIImage(named: "tab_followable_items_active")
            rightImageView.image = UIImage(named: "tab_followed_items_inactive")
            letfLabel.textColor = .systemBlue
            rightLabel.textColor = .systemGray2

        default:
            leftImageView.image = UIImage(named: "tab_followable_items_inactive")
            rightImageView.image = UIImage(named: "tab_followed_items_active")
            letfLabel.textColor = .systemGray2
            rightLabel.textColor = .systemBlue
        }
    }
}

extension ViewController: SwipeDelegate {
    func changeMenuTo(_ index: Int) {
        changeUI(index)
    }
}
