//
//  FormPageController.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/15/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit

protocol FormPageControllerDelegate: class {
    func moveToNextPage()
    func moveToPrevPage()
}

class FormPageController: UIPageViewController {
    
    var pageViewControllers = [UIViewController]()
    
    var formPageControllerDelegate: FormPageControllerDelegate?
    
    var pages: [Page]{
        return MockData.fetchForms()?.pages ?? []
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        
        super.init(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //delegate = self
        //dataSource = self
        
        for page in pages {
            pageViewControllers.append(ViewController(page: page))
        }
        
        let initialVc = pageViewControllers[0]
        setViewControllers([initialVc], direction: .forward,
                           animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if pages.isEmpty {
            dismiss(animated: true)
        }
    }
}

extension FormPageController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pageViewControllers.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                return nil
            } else {
                let pageVC = self.pageViewControllers[viewControllerIndex - 1]
                return pageVC
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pageViewControllers.firstIndex(of: viewController) {
            if viewControllerIndex < self.pageViewControllers.count - 1 {
                let pageVC = self.pageViewControllers[viewControllerIndex + 1]
                return pageVC
            } else {
                return nil
            }
        }
        return nil
    }
}

//extension FormPageController: UIPageViewControllerDelegate {
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        let pageContentViewController = pageViewController.viewControllers![0]
//        self.formPageControllerDelegate?.newPageShownAt(index: pageViewControllers.firstIndex(of: pageContentViewController) ?? 0)
//    }
//}

extension FormPageController {
    func goToNext(index: Int) {
        //        initialPage += 1
        //        if initialPage > pages.count - 1 {
        //            return
        //        }
        goToNextPage(index: index) {[weak self] (completed) in
            if completed {
                self?.formPageControllerDelegate?.moveToNextPage()
            }
        }
    }
    
    func goToPrevious(index: Int) {
        //        initialPage -= 1
        //        if initialPage < 0 {
        //            return
        //        }
        goToPreviousPage(index: index) {[weak self] (completed) in
            if completed {
                self?.formPageControllerDelegate?.moveToPrevPage()
            }
        }
    }
}

extension FormPageController {
    
    func goToNextPage(animated: Bool = true, completed: ((Bool) -> ())? = nil) {
        guard let currentViewController = self.viewControllers?.first else {
            completed?(false)
            return
        }
        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else {
            completed?(false)
            return
        }
        setViewControllers([nextViewController], direction: .forward, animated: animated, completion: nil)
        completed?(true)
    }
    
    func goToNextPage(index: Int, animated: Bool = true, completed: ((Bool) -> ())? = nil) {
        guard (self.viewControllers?.first) != nil else {
            completed?(false)
            return
        }
        
        let nextViewController = self.pageViewControllers[index]
        setViewControllers([nextViewController], direction: .forward, animated: animated, completion: nil)
        
        completed?(true)
    }
    
    func goToPreviousPage(animated: Bool = true, completed: ((Bool) -> ())? = nil) {
        guard let currentViewController = self.viewControllers?.first else {
            completed?(false)
            return
        }
        guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else {
            completed?(false)
            return
        }
        setViewControllers([previousViewController], direction: .reverse, animated: animated, completion: nil)
        completed?(true)
    }
    
    func goToPreviousPage(index: Int, animated: Bool = true, completed: ((Bool) -> ())? = nil) {
        guard (self.viewControllers?.first) != nil else {
            completed?(false)
            return
        }
        let previousViewController = self.pageViewControllers[index]
        setViewControllers([previousViewController], direction: .reverse, animated: animated, completion: nil)
        completed?(true)
    }
    
}
