//
//  PageViewController.swift
//  myNews
//
//  Created by Pu Yue - PU YUE on 2022/06/30.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController {
    
    private var controllers: [UIViewController] = []
    var swipeDelegate: SwipeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        initPageView()
    }
    
    func initPageView() {
        let firstVC = storyboard!.instantiateViewController(withIdentifier: "FirstCollectionController") as! FirstCollectionController
        let secondVC = storyboard!.instantiateViewController(withIdentifier: "SecondCollectionController") as! SecondCollectionController
        self.controllers = [ firstVC, secondVC ]
        setViewControllers([self.controllers[0]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
    
    func movePageTo(_ index: Int) {
        switch index {
        case 0:
            self.setViewControllers([self.controllers[0]], direction: .reverse, animated: true, completion: nil)
        default:
            self.setViewControllers([self.controllers[1]], direction: .forward, animated: true, completion: nil)
        }
    }
    
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.controllers.count
    }
    
    // index 0 -> 1
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController),
           index < self.controllers.count - 1 {
            return self.controllers[index + 1]
        } else {
            return nil
        }
    }
    
    // index 0 <- 1
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController),
           index > 0 {
            return self.controllers[index - 1]
        } else {
            return nil
        }
    }
    
    // swipe event
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard
            let newViewController = pageViewController.viewControllers?.first,
            let newIndex = self.controllers.firstIndex(of: newViewController)
        else { return }
        DispatchQueue.main.async { [weak self] in
            self?.swipeDelegate?.changeMenuTo(newIndex)
        }
    }
}
