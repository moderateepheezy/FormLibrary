//
//  ViewController.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/13/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let formController = FormViewController()
    
    var page: Page
    
    var formElements: [FormElement] = []
    
    // MARK - Lifecycle
    required init(page: Page) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    init() {
        fatalError("Must be initialised using init(page:)")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Must be initialised using init(page:)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = page.label
        
        view.addSubview(formController.view)
        formController.delegate = self
        let safeArea = self.view.safeAreaLayoutGuide
        formController.view.topAnchor.align(to: safeArea.topAnchor)
        formController.view.leadingAnchor.align(to: view.leadingAnchor)
        formController.view.trailingAnchor.align(to: view.trailingAnchor)
        formController.view.bottomAnchor.align(to: view.bottomAnchor)
        
        setFormStyle()
        
        formController.cells = createCells()
        formController.reloadCollectionView()
        
    }
    
    private func setFormStyle() {
        CellStyle.shared.fieldTitleColor = .black
        CellStyle.shared.fieldEntryColor = .black
        CellStyle.shared.fieldPlaceholderColor = .gray
        CellStyle.shared.fieldBorderColor = .black
        CellStyle.shared.fieldErrorColor = .red
        CellStyle.shared.fieldDisabledColor = .gray
        CellStyle.shared.buttonLabelColor = .black
        CellStyle.shared.sectionTitleColor = .black
        CellStyle.shared.titleColor = .black
        CellStyle.shared.subTitleColor = .gray
        
        CellStyle.shared.setFormMargins(leading: 20, trailing: 20, top: 20, bottom: 20)
        CellStyle.shared.interItemFieldSpacing = 20
        CellStyle.shared.lineSpacing = 20
        CellStyle.shared.fieldTitleBottomMargin = 0
        CellStyle.shared.sectionTitleTopMargin = 10
        CellStyle.shared.sectionTitleBottomMargin = 10
        CellStyle.shared.fieldCornerRadius = 2
        CellStyle.shared.fieldBorderWidth = 1
        CellStyle.shared.checkboxItemSpacing = 8
        CellStyle.shared.titleSubTitleTopMargin = 20
        CellStyle.shared.titleSubTitleBottomMargin = 10
        CellStyle.shared.titleSubTitleVerticalSpacing = 10
        CellStyle.shared.errorTopMargin = 5
        
        CellStyle.shared.fieldTitleFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        CellStyle.shared.sectionTitleFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        CellStyle.shared.fieldButtonFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        CellStyle.shared.titleFont = UIFont.systemFont(ofSize: 18, weight: .medium)
        CellStyle.shared.subTitleFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        CellStyle.shared.fieldErrorFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        CellStyle.shared.textFieldStyle = .underline
        CellStyle.shared.bounce = true
    }
    
    private func createCells() -> [FormViewController.Cell] {
        var cells = [FormViewController.Cell]()
        let sections = page.sections
        for section in sections {
            cells.append(FormViewController.Cell(id: page.label, type: .title, widthPercentage: 1.0,
                                                 data: FormSectionTitleCell.Data(title: section.label)))
            formElements = section.elements
            for formElement in formElements {
                cells.append(
                    FormViewController.Cell(id: formElement.uniqueID, type: formElement.cellType, widthPercentage: 1.0, data: formElement.cellData)
                )
            }
        }
        return cells
    }
}

extension ViewController: FormViewControllerDelegate {
    
    func formViewController(_ controller: FormViewController, date: Date?, forCellId id: String) {
        guard let date = date else {return}
        print(date.description)
    }
    
    
    func formViewController(_ controller: FormViewController, updatedText: String?, forCellId id: String) {
        
        guard let updatedText = updatedText else {
            return
        }
        
//        switch (id) {
//        }
        
    }
    
    
    
    func formViewController(_ controller: FormViewController, selectedIndex: Int, valueAtIndex: String, forCellId id: String) {
        
        if id.contains("yesno") {
            let yesnoElement = formElements.filter {$0.uniqueID == id}.first
            guard let element = yesnoElement else { return }
            let rules = element.rules
            for rule in rules {
                switch rule.condition {
                case "equals":
                    if rule.value.uppercased() == valueAtIndex.uppercased()
                        && rule.action == "show" {
                        rule.targets.forEach {[unowned self] in
                            self.formController.showHiddeCellWith(id: $0)
                        }
                    } else {
                        rule.targets.forEach {[unowned self] in
                            self.formController.hideCellWith(id: $0)
                        }
                    }
                default:
                    print("")
                }
            }
        }
        
    }
    
    func formViewController(_ controller: FormViewController, pressedButtonForCellId id: String) {
//        switch (id) {
//
//        }
    }
    
    func formViewController(_ controller: FormViewController, checked: Bool?, option: Int, forCellId id: String) {
        
//        switch (id) {
//
//        }
        
    }
    
    func formViewController(_ controller: FormViewController, updateCustomCell cell: UICollectionViewCell, forCellId id: String) -> UICollectionViewCell {
        
//        if id == CellId.optIn.rawValue {
//            if let cell = cell as? ExampleCustomCell {
//                cell.update(title: "Lorem ipsum")
//            }
//        }
        
        return cell
    }
    
}
