//
//  FormDropdownCell.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/10/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//


import UIKit
import DropDown

protocol FormDropdownCellDelegate {
    func formDropdownCell(_ cell: FormDropdownCell, selected index: Int, stringValueIndex: String)
}

public class FormDropdownCell: UICollectionViewCell, FormCell {
    
    public class Data: CellData {
        let title: String?
        let selection: String?
        let placeholder: String?
        let options: [String]
        
        public init(title: String? = nil, selection: String? = nil, placeholder: String? = nil, options: [String]) {
            self.title = title
            self.selection = selection
            self.placeholder = placeholder
            self.options = options
        }
    }

    //MARK: - IBOutlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleBottomConstraint: NSLayoutConstraint!
    @IBOutlet var entryLabel: UILabel!
    @IBOutlet var entryView: UIView!
    @IBOutlet var indicatorImageView: UIImageView!
    
    //MARK: - Properties
    var delegate: FormDropdownCellDelegate?
    fileprivate var options: [String]?
    fileprivate let dropDown = DropDown()
    
    //MARK: - Constants
    
    /* The text field horizontal inset */
    public static var textFieldInternalHorizontalInsets: CGFloat = 10
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        
    }
    
    private func setupUI() {
        
        self.titleLabel.textColor = CellStyle.shared.fieldTitleColor
        self.titleLabel.font = CellStyle.shared.fieldTitleFont
        self.titleBottomConstraint.constant = CellStyle.shared.fieldTitleBottomMargin
        
        let dropdownImage = UIImage(named: "ic_dropdown")
        self.indicatorImageView.image = dropdownImage?.withRenderingMode(.alwaysTemplate)
        self.indicatorImageView.tintColor = CellStyle.shared.fieldBorderColor
        
        entryView.backgroundColor = .white
        entryLabel.textColor = CellStyle.shared.fieldPlaceholderColor
        entryLabel.font = CellStyle.shared.fieldPlaceholderFont
        entryLabel.tintColor = CellStyle.shared.fieldEntryColor
        
        switch (CellStyle.shared.textFieldStyle) {
        case .box:
            entryView.layer.cornerRadius = CellStyle.shared.fieldCornerRadius
            entryView.layer.borderWidth = CellStyle.shared.fieldBorderWidth
            entryView.layer.borderColor = CellStyle.shared.fieldBorderColor.cgColor
            break
        case .underline:
            let border = CALayer()
            border.borderColor = CellStyle.shared.fieldBorderColor.cgColor
            border.frame = CGRect(x: 0, y: entryView.frame.size.height - CellStyle.shared.fieldBorderWidth, width: entryView.frame.size.width, height: entryView.frame.size.height)
            border.borderWidth = CellStyle.shared.fieldBorderWidth
            entryView.layer.addSublayer(border)
            entryView.layer.masksToBounds = true
            break
        }
        
        DropDown.startListeningToKeyboard()
        self.dropDown.anchorView = self.entryView
        self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.entryLabel.text = item
            self.entryLabel.textColor = CellStyle.shared.fieldEntryColor
            self.delegate?.formDropdownCell(self, selected: index, stringValueIndex: item)
        }
    }
    
    public func update(_ data: Data) {
        
        var title = data.title
        if title == nil || title?.count == 0 {
            title = " "
        }
        titleLabel.text = title
        if data.selection == nil || data.selection?.count == 0 {
            entryLabel.text = data.placeholder
            entryLabel.textColor = CellStyle.shared.fieldPlaceholderColor
        } else {
            entryLabel.text = data.selection
            entryLabel.textColor = CellStyle.shared.fieldEntryColor
        }
        options = data.options
        self.dropDown.dataSource = options ?? []
        
    }
    
    @IBAction private func dropdownSelected(sender: Any) {
        self.dropDown.show()
    }

}
