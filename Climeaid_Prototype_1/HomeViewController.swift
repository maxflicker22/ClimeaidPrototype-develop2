//
//  HomeViewController.swift
//  Climeaid_Prototype_1
//
//  Created by Manuel Plaschzug on 14.05.19.
//  Copyright © 2019 Manuel Plaschzug. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    
    private var pageViewController: UIPageViewController!
    
    private lazy var viewControllers: [UIViewController] = {
        var viewControllers = [UIViewController]()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let firstViewController = storyboard.instantiateViewController(withIdentifier: "vcLoginTutorial1")
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "vcLoginTutorial2")
        let thirdViewController = storyboard.instantiateViewController(withIdentifier: "vcLoginTutorial3")
        viewControllers.append(firstViewController)
        viewControllers.append(secondViewController)
        viewControllers.append(thirdViewController)
        
        
        return viewControllers
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UIPageViewController {
            pageViewController = vc
            pageViewController.dataSource = self
            pageViewController.delegate = self
            pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
            
        }
    }

}

extension HomeViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = viewControllers.lastIndex(of: viewController){
            let newIndex = index - 1
            if newIndex < 0 {
                return nil
            } else {
                return viewControllers[newIndex]
            }
            
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = viewControllers.lastIndex(of: viewController){
            let newIndex = index + 1
            if newIndex >= viewControllers.count{
                return nil
            } else {
                return viewControllers[newIndex]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed{
            if let viewController = pageViewController.viewControllers?.first{
                if let index = viewControllers.lastIndex(of: viewController) {
                    //                    title = titles[index]
                    pageControl.currentPage = index
                }
            }
        }
    }
    
    
    
    
}
