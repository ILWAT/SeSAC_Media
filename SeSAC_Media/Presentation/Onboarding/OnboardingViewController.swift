//
//  OnboardingViewController.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/27.
//

import UIKit
import SnapKit

class OnboardingViewController: UIPageViewController {
    
    let firstViewController = ReusableOnboardingViewController()
    let secondViewController = ReusableOnboardingViewController()
    let thirdViewController = ReusableOnboardingViewController()
    
    var list: [UIViewController] = []
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .pageCurl, navigationOrientation: .horizontal)
        
        list = [firstViewController, secondViewController, thirdViewController]
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        
        setUI()
        guard let vc = list.first else { return }
        setViewControllers([vc], direction: .forward, animated: true)
       
    }
    
    func setUI(){
        firstViewController.setImage(systemName: "checkmark")
        secondViewController.setImage(systemName: "heart.circle")
        thirdViewController.setImage(systemName: "star.circle")
    }

}

extension OnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else {return nil}
        
        let previousIndex = currentIndex - 1
        
        return previousIndex  < 0 ? nil : list[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else {return nil}
        
        let afterIndex  = currentIndex + 1
        
        if afterIndex == list.count - 1 {
            guard let vc = list[afterIndex] as? ReusableOnboardingViewController else { return afterIndex >= list.count ? nil : list[afterIndex] }
            vc.setLastButton(visible: false)
        }
        
        return afterIndex >= list.count ? nil : list[afterIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return list.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first , let index = list.firstIndex(of: first) else { return 0 }
        
        return index
    }
}
