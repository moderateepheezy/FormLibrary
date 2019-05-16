//
//  FormContainer.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/15/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit

class FormContainer: UIViewController {

    let formViewController = FormPageController()
    
    var pageCount: Int {
        return formViewController.pages.count
    }
    
    var currentIndex: Int = 0 {
        didSet {
            self.title = formViewController.pages[currentIndex].label
            setButtonsState(index: currentIndex)
        }
    }
    
    private lazy var formContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var prevButton: UIButton = {
        let button = UIButton()
        button.setTitle("PREV", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.isHidden = true
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(prevTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("SUBMIT", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.isHidden = true
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:
            [prevButton, nextButton, submitButton])
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentIndex = 0
        
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        addChild(formViewController)
        formViewController.formPageControllerDelegate = self
        formViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        pageControl.numberOfPages = pageCount
        pageControl.isHidden = pageCount < 2
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        view.addSubview(pageControl)
        view.addSubview(formContainerView)
        view.addSubview(formViewController.view)
        
        stackView.bottomAnchor
            .align(to: view.safeAreaLayoutGuide.bottomAnchor, offset: -10)
        stackView.leadingAnchor.align(to: view.leadingAnchor, offset: 10)
        stackView.trailingAnchor.align(to: view.trailingAnchor, offset: -10)
        stackView.heightAnchor.equal(to: 44)
        
        pageControl.bottomAnchor.align(to: stackView.topAnchor, offset: -10)
        pageControl.centerXAnchor.align(to: view.centerXAnchor)
        
        formContainerView.topAnchor.align(to: view.topAnchor)
        formContainerView.leadingAnchor.align(to: view.leadingAnchor)
        formContainerView.trailingAnchor.align(to: view.trailingAnchor)
        formContainerView.bottomAnchor.align(to: pageControl.topAnchor, offset: -10)
        
        formViewController.view.topAnchor.align(to: formContainerView.topAnchor)
        formViewController.view.leadingAnchor.align(to: formContainerView.leadingAnchor)
        formViewController.view.trailingAnchor.align(to: formContainerView.trailingAnchor)
        formViewController.view.bottomAnchor.align(to: formContainerView.bottomAnchor)
        didMove(toParent: self)
    }
    
    @objc private func nextTapped() {
        currentIndex = currentIndex +  1
        formViewController.goToNext(index: currentIndex)
    }
    
    @objc private func prevTapped() {
        currentIndex = currentIndex - 1
        formViewController.goToPrevious(index: currentIndex)
    }
    
    @objc private func submitTapped() {
        
    }
    
    func setButtonsState(index: Int) {
        pageControl.currentPage = index
        if index == 0 {
            prevButton.isHidden = true
            submitButton.isHidden = true
            nextButton.isHidden = false
        } else if index == pageCount - 1 {
            nextButton.isHidden = true
            submitButton.isHidden = false
            prevButton.isHidden = false
        } else {
            nextButton.isHidden = false
            submitButton.isHidden = true
            prevButton.isHidden = false
        }
    }

}

extension FormContainer: FormPageControllerDelegate {
    func moveToNextPage() {
        //currentIndex = currentIndex +  1
    }
    
    func moveToPrevPage() {
        //currentIndex = currentIndex -  1
    }
}
