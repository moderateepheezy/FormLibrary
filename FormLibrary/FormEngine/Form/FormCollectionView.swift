//
//  FormCollectionView.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/14/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit

class FormCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.setupCollectionView()
        self.initCells()
        
        self.contentInsetAdjustmentBehavior = .never
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupCollectionView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.allowsMultipleSelection = false
        self.alwaysBounceVertical = false
        self.bounces = CellStyle.shared.bounce
        self.contentInset = .zero
        self.scrollIndicatorInsets = .zero
    }
    
    fileprivate func initCells() {
        self.register(UINib(nibName: FormTextFieldCell.reuseIdentifier(), bundle: Bundle.init(for: FormViewController.self)), forCellWithReuseIdentifier: FormTextFieldCell.reuseIdentifier())
        self.register(UINib(nibName: FormButtonOptionsCell.reuseIdentifier(), bundle: Bundle.init(for: FormViewController.self)), forCellWithReuseIdentifier: FormButtonOptionsCell.reuseIdentifier())
        self.register(UINib(nibName: FormCheckboxOptionsCell.reuseIdentifier(), bundle: Bundle.init(for: FormViewController.self)), forCellWithReuseIdentifier: FormCheckboxOptionsCell.reuseIdentifier())
        self.register(UINib(nibName: FormDropdownCell.reuseIdentifier(), bundle: Bundle.init(for: FormViewController.self)), forCellWithReuseIdentifier: FormDropdownCell.reuseIdentifier())
        self.register(UINib(nibName: FormSectionTitleCell.reuseIdentifier(), bundle: Bundle.init(for: FormViewController.self)), forCellWithReuseIdentifier: FormSectionTitleCell.reuseIdentifier())
        self.register(UINib(nibName: FormTitleSubtitleCell.reuseIdentifier(), bundle: Bundle.init(for: FormViewController.self)), forCellWithReuseIdentifier: FormTitleSubtitleCell.reuseIdentifier())
        self.register(UINib(nibName: FormLabelCell.reuseIdentifier(), bundle: Bundle.init(for: FormViewController.self)), forCellWithReuseIdentifier: FormLabelCell.reuseIdentifier())
        self.register(UINib(nibName: FormButtonCell.reuseIdentifier(), bundle: Bundle.init(for: FormViewController.self)), forCellWithReuseIdentifier: FormButtonCell.reuseIdentifier())
        self.register(UINib(nibName: FormPasswordCell.reuseIdentifier(), bundle: Bundle.init(for: FormViewController.self)), forCellWithReuseIdentifier: FormPasswordCell.reuseIdentifier())
        self.register(UINib(nibName: FormPhotoCell.reuseIdentifier(), bundle: Bundle.init(for: FormViewController.self)), forCellWithReuseIdentifier: FormPhotoCell.reuseIdentifier())
        self.register(UINib(nibName: FormDatePickerCell.reuseIdentifier(), bundle: Bundle.init(for: FormViewController.self)), forCellWithReuseIdentifier: FormDatePickerCell.reuseIdentifier())
    }
    
}
