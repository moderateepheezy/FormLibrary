//
//  FormViewController.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/12/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit

public protocol FormViewControllerDelegate {
    
    /** Called when a text entry input changed. */
    func formViewController(_ controller: FormViewController, updatedText: String?, forCellId id: String)
    
    /** Called when an option is selected. */
    func formViewController(_ controller: FormViewController, selectedIndex: Int, valueAtIndex: String, forCellId id: String)
    
    /** Called when a button is pressed. */
    func formViewController(_ controller: FormViewController, pressedButtonForCellId id: String)
    
    /** Called when a checkbox is checked/unchecked. */
    func formViewController(_ controller: FormViewController, checked: Bool?, option: Int, forCellId id: String)
    
    /** Called when a date picker value changed. */
    func formViewController(_ controller: FormViewController, date: Date?, forCellId id: String)
    
    /** Called when a custom cell is about to be drawn and needs to be updated */
    func formViewController(_ controller: FormViewController, updateCustomCell cell: UICollectionViewCell, forCellId id: String) -> UICollectionViewCell
    
}

public class FormViewController: UIViewController {
    
    public enum CellType {
        case photo
        case title
        case titleSubtitle
        case label
        case button
        case text
        case buttonOptions
        case checkboxOptions
        case dropdown
        case password
        case date
        case custom
    }
    
    public class Cell: Equatable {
        let id: String
        let type: CellType
        let widthPercentage: CGFloat
        let data: CellData?
        let customCell: AnyClass?
        var isVisible: Bool
        
        public init(id: String, type: CellType, widthPercentage: CGFloat, data: CellData?, isVisible: Bool = true, customCell: AnyClass? = nil) {
            self.id = id
            self.type = type
            self.widthPercentage = widthPercentage
            self.data = data
            self.customCell = customCell
            self.isVisible = isVisible
        }
        
        public static func ==(lhs: Cell, rhs: Cell) -> Bool {
            return lhs === rhs
        }
    }
    
    fileprivate let collectionViewLayout = CustomCollectionViewFlowLayout()
    private lazy var collectionView: FormCollectionView = {
        let collectionView = FormCollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    //MARK: - Properties
    
    public var cells: [Cell]? {
        didSet {
            if let cells = cells {
                for cell in cells {
                    if cell.type == .custom {
                        if let customCell = cell.customCell {
                            self.collectionView.register(UINib(nibName: String(describing: customCell), bundle: Bundle.init(for: customCell)), forCellWithReuseIdentifier:String(describing: customCell))
                        }
                    }
                }
            }
            reloadCollectionView()
        }
    }
    
    public var delegate: FormViewControllerDelegate?
    
    //MARK: - Lifecycle
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .clear
        view.addSubview(collectionView)
        setUpConstraints()
        
    }
    
    
    //MARK: - Public Functions
    
    public func reloadCollectionView() {
        self.collectionViewLayout.invalidateLayout()
        self.collectionView.reloadData()
    }
    
    
    //MARK: - Private Functions
    
    fileprivate func setUpConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        collectionView.topAnchor.align(to: safeArea.topAnchor)
        collectionView.leadingAnchor.align(to: view.leadingAnchor)
        collectionView.trailingAnchor.align(to: view.trailingAnchor)
        collectionView.bottomAnchor.align(to: view.bottomAnchor)
    }
    
    public func getConfiguredCell(cellTemplate: FormViewController.Cell, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch cellTemplate.type {
        case .title:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormSectionTitleCell.reuseIdentifier(), for: indexPath) as? FormSectionTitleCell {
                if let data = cellTemplate.data as? FormSectionTitleCell.Data {
                    cell.update(data)
                }
                return cell
            }
        case .titleSubtitle:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormTitleSubtitleCell.reuseIdentifier(), for: indexPath) as? FormTitleSubtitleCell {
                if let data = cellTemplate.data as? FormTitleSubtitleCell.Data {
                    cell.update(data)
                }
                return cell
            }
        case .text:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormTextFieldCell.reuseIdentifier(), for: indexPath as IndexPath) as? FormTextFieldCell {
                cell.delegate = self
                if let data = cellTemplate.data as? FormTextFieldCell.Data {
                    cell.update(data)
                }
                return cell
            }
        case .buttonOptions:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormButtonOptionsCell.reuseIdentifier(), for: indexPath as IndexPath) as? FormButtonOptionsCell {
                cell.delegate = self
                if let data = cellTemplate.data as? FormButtonOptionsCell.Data {
                    cell.update(data)
                }
                return cell
            }
        case .dropdown:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormDropdownCell.reuseIdentifier(), for: indexPath as IndexPath) as? FormDropdownCell {
                cell.delegate = self
                if let data = cellTemplate.data as? FormDropdownCell.Data {
                    cell.update(data)
                }
                
                return cell
            }
        case .label:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormLabelCell.reuseIdentifier(), for: indexPath) as? FormLabelCell {
                if let data = cellTemplate.data as? FormLabelCell.Data {
                    cell.update(data)
                }
                return cell
            }
        case .button:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormButtonCell.reuseIdentifier(), for: indexPath) as? FormButtonCell {
                cell.delegate = self
                if let data = cellTemplate.data as? FormButtonCell.Data {
                    cell.update(data)
                }
                return cell
            }
        case .checkboxOptions:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormCheckboxOptionsCell.reuseIdentifier(), for: indexPath) as? FormCheckboxOptionsCell {
                cell.delegate = self
                if let data = cellTemplate.data as? FormCheckboxOptionsCell.Data {
                    cell.update(data)
                }
                return cell
            }
        case .password:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormPasswordCell.reuseIdentifier(), for: indexPath) as? FormPasswordCell {
                cell.delegate = self
                if let data = cellTemplate.data as? FormPasswordCell.Data {
                    cell.update(data)
                }
                return cell
            }
        case .photo:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormPhotoCell.reuseIdentifier(), for: indexPath) as? FormPhotoCell {
                if let data = cellTemplate.data as? FormPhotoCell.Data {
                    cell.update(data)
                }
                return cell
            }
        case .date:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormDatePickerCell.reuseIdentifier(), for: indexPath) as? FormDatePickerCell {
                if let data = cellTemplate.data as? FormDatePickerCell.Data {
                    cell.update(data)
                }
                return cell
            }
        case .custom:
            if let customCell = cellTemplate.customCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: customCell), for: indexPath)
                return self.delegate?.formViewController(self, updateCustomCell: cell, forCellId: cellTemplate.id) ?? UICollectionViewCell()
            }
        }
        return UICollectionViewCell()
    }
    
    func hideCellWith(id: String) {
        if let cells = cells,
            let cell = cells.filter({$0.id == id}).first,
            let index = cells.firstIndex(of: cell) {
            let updatedCell = cell
            updatedCell.isVisible = false
            self.cells?[index] = updatedCell
            let indexPath = IndexPath(item: index, section: 0)
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
    func showHiddeCellWith(id: String) {
        if let cells = cells,
            let cell = cells.filter({$0.id == id}).first,
            let index = cells.firstIndex(of: cell) {
            let updatedCell = cell
            updatedCell.isVisible = true
            self.cells?[index] = updatedCell
            let indexPath = IndexPath(item: index, section: 0)
            collectionView.reloadItems(at: [indexPath])
        }
    }

}

extension FormViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cells = cells else {
            return CGSize(width: 0, height: 0)
        }
        let cell = cells[indexPath.row]
        if cell.isVisible == false {
            return CGSize(width: 0, height: 0)
        }
        let rowItemCount = getRowItemCountForIndex(indexPath)
        let margins = CellStyle.shared.leadingMargin + CellStyle.shared.trailingMargin
        let totalInteritemSpacing = (CellStyle.shared.interItemFieldSpacing) * CGFloat(rowItemCount - 1)
        let availableWidth = collectionView.frame.size.width - margins - totalInteritemSpacing
        let width = cell.widthPercentage * availableWidth
        
        let size = calculateDynamicCellHeight(cellTemplate: cell, collectionView: collectionView, indexPath: indexPath)
        return CGSize(width: floor(width), height: size.height)
    }

    private func calculateDynamicCellHeight(cellTemplate: FormViewController.Cell, collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        
        let sizingCell = getConfiguredCell(cellTemplate: cellTemplate, collectionView: collectionView, indexPath: indexPath)
        sizingCell.setNeedsLayout()
        sizingCell.layoutIfNeeded()
        let size = sizingCell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        switch cellTemplate.type {
        case .photo:
            return CGSize(width: 100, height: 100)
        case .date:
            return CGSize(width: size.width, height: 80)
        default:
            return size
        }
    }
    
    private func getRowItemCountForIndex(_ indexPath: IndexPath) -> Int {
        guard let cells = cells else {
            return 0
        }
        var currentRowWidth: CGFloat = 0
        var currentRowItemCount: Int = 0
        var insideTargetRow = false
        for (index, element) in cells.enumerated() {
            if indexPath.row == index {
                insideTargetRow = true
            }
            currentRowItemCount += 1
            currentRowWidth += element.widthPercentage
            
            if index == (cells.count-1) && insideTargetRow {
                return currentRowItemCount
            } else if (currentRowWidth + cells[index+1].widthPercentage) > 1.0 {
                if insideTargetRow {
                    return currentRowItemCount
                }
                currentRowWidth = 0
                currentRowItemCount = 0
            }
        }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CellStyle.shared.interItemFieldSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CellStyle.shared.lineSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CellStyle.shared.topMargin, left: CellStyle.shared.leadingMargin, bottom: CellStyle.shared.bottomMargin, right: CellStyle.shared.trailingMargin)
    }
    
}

extension FormViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let cells = cells {
            return cells.count
        }
        
        return 0
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cells = cells else {
            return UICollectionViewCell()
        }
        let cellTemplate = cells[indexPath.row]
        let cell = getConfiguredCell(cellTemplate: cellTemplate, collectionView: collectionView, indexPath: indexPath)
        cell.layoutIfNeeded()
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


//MARK: - Text Field

extension FormViewController: FormTextFieldCellDelegate {
    
    func formTextFieldCell(_ cell: FormTextFieldCell, updatedText: String?) {
        
        let indexPath = collectionView.indexPath(for: cell)
        guard let row = indexPath?.row, let cells = cells else {
            return
        }
        let masterCell = cells[row]
        delegate?.formViewController(self, updatedText: updatedText, forCellId: masterCell.id)
        
    }
    
    public func formTextFieldCellShouldReturn(_ cell: FormTextFieldCell, textField: UITextField) -> Bool {
        guard let cells = cells, let indexPath = collectionView.indexPath(for: cell) else {
            textField.resignFirstResponder()
            return false
        }
        for row in (indexPath.row+1)..<cells.count {
            if let theCell = collectionView.cellForItem(at: IndexPath.init(row: row, section: indexPath.section)) as? FormTextFieldCell {
                theCell.getTextField().becomeFirstResponder()
                return false
            }
            
        }
        textField.resignFirstResponder()
        return false
    }
}


//MARK: - Button Options

extension FormViewController: FormButtonOptionsCellDelegate {
    func formButtonOptionsCell(_ cell: FormButtonOptionsCell, selectedOptionIndex: Int, stringAtIndex: String) {
        let indexPath = collectionView.indexPath(for: cell)
        guard let row = indexPath?.row, let cells = cells else {
            return
        }
        let masterCell = cells[row]
        delegate?.formViewController(self, selectedIndex: selectedOptionIndex, valueAtIndex: stringAtIndex, forCellId: masterCell.id)
    }
}


//MARK: - Picker

extension FormViewController: FormDropdownCellDelegate {
    
    func formDropdownCell(_ cell: FormDropdownCell, selected index: Int, stringValueIndex: String) {
        let indexPath = collectionView.indexPath(for: cell)
        guard let row = indexPath?.row, let cells = cells else {
            return
        }
        let masterCell = cells[row]
        delegate?.formViewController(self, selectedIndex: index, valueAtIndex: stringValueIndex, forCellId: masterCell.id)
    }
}


//MARK: - Button

extension FormViewController: ButtonCellDelegate {
    
    func formButtonCellPressed(_ cell: FormButtonCell) {
        let indexPath = collectionView.indexPath(for: cell)
        guard let row = indexPath?.row, let cells = cells else {
            return
        }
        let masterCell = cells[row]
        delegate?.formViewController(self, pressedButtonForCellId: masterCell.id)
    }
    
}


//MARK: - Checkbox Options

extension FormViewController: FormCheckboxOptionsCellDelegate {
    
    func formCheckboxOptionsCell(_ cell: FormCheckboxOptionsCell, checked: Bool, forIndex: Int) {
        let indexPath = collectionView.indexPath(for: cell)
        guard let row = indexPath?.row, let cells = cells else {
            return
        }
        let masterCell = cells[row]
        delegate?.formViewController(self, checked: checked, option: forIndex, forCellId: masterCell.id)
    }
    
}

//MARK: - Date Picker

extension FormViewController: FormDatePickerCellCellDelegate {
    func formDatePickerCell(_ cell: FormDatePickerCell, date: Date?) {
        let indexPath = collectionView.indexPath(for: cell)
        guard let row = indexPath?.row, let cells = cells else {
            return
        }
        let masterCell = cells[row]
        delegate?.formViewController(self, date: date, forCellId: masterCell.id)
    }
}


// MARK: - Password

extension FormViewController: FormPasswordCellDelegate {
    
    func formPasswordCell(_ cell: FormPasswordCell, updatedText: String?) {
        let indexPath = collectionView.indexPath(for: cell)
        guard let row = indexPath?.row, let cells = cells else {
            return
        }
        let masterCell = cells[row]
        delegate?.formViewController(self, updatedText: updatedText, forCellId: masterCell.id)
    }
    
    func formPasswordCellShouldReturn(_ cell: FormPasswordCell, textField: UITextField) -> Bool {
        guard let cells = cells, let indexPath = collectionView.indexPath(for: cell) else {
            textField.resignFirstResponder()
            return false
        }
        for row in (indexPath.row+1)..<cells.count {
            if let theCell = collectionView.cellForItem(at: IndexPath.init(row: row, section: indexPath.section)) as? FormTextFieldCell {
                theCell.getTextField().becomeFirstResponder()
                return false
            }
            
        }
        textField.resignFirstResponder()
        return false
    }
    
}
