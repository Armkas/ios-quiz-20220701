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
    
    /*假如不用containerView 就要用以下方法才能把一个VC加进另一个VC
    let vc: PageViewController() = XXX
    self.addChild(vc)//先把vc加入另一个vc
    vc.view.frame = contentView.bounds  设定子View宽度，注意是子VC外边等于父VC内边// or, better, turn off `translatesAutoresizingMaskIntoConstraints` and then define constraints for this subview
    contentView.addSubview(vc.view)//然后View级别也要加进去
     */

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftView.isUserInteractionEnabled = true
        let clickLeft = UITapGestureRecognizer.init(target: self, action: #selector(clickLeft))
        leftView.addGestureRecognizer(clickLeft)
        rightView.isUserInteractionEnabled = true
        let clickRight = UITapGestureRecognizer.init(target: self, action: #selector(clickRight))
        rightView.addGestureRecognizer(clickRight)
    }
    
    //这个方法能取得整个sb中所有VC的实例，从中选择需要的就行
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get PageViewController object
        if let vc = segue.destination as? PageViewController {
            self.pageViewControllerObject = vc
            vc.swipeDelegate = self//要没有这个这里的delegate不好弄，因为隔了一个contain view
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
