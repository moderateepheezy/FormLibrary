//
//  FormDatePickerCell.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/14/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit

protocol FormDatePickerCellCellDelegate: class {
    func formDatePickerCell(_ cell: FormDatePickerCell, date: Date?)
}

class FormDatePickerCell: UICollectionViewCell, FormCell {
    
    private var showDateVisible = false {
        didSet {
            if !showDateVisible {
                textField.resignFirstResponder()
            }
            textField.becomeFirstResponder()
           // pickerHeightContraint.constant = showDateVisible ? 110 : 0
        }
    }
    
    override var isSelected: Bool {
        didSet {
            showDateVisible = !showDateVisible
        }
    }
    
    public class Data: CellData {
        let title: String
        var mode: UIDatePicker.Mode
        
        public init(title: String, mode: UIDatePicker.Mode) {
            self.title = title
            self.mode = mode
        }
    }
    
    weak var formDatePickerCellDelegate: FormDatePickerCellCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    let datePicker = UIDatePicker()
    
    
    @IBOutlet weak var titleValueMarginContraint: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = CellStyle.shared.fieldTitleColor
        titleLabel.font = CellStyle.shared.fieldTitleFont
        textField.textColor = CellStyle.shared.subTitleColor
        textField.font = CellStyle.shared.subTitleFont
        
        switch CellStyle.shared.textFieldStyle {
        case .box:
            textField.layer.cornerRadius = CellStyle.shared.fieldCornerRadius
            textField.layer.borderWidth = CellStyle.shared.fieldBorderWidth
            textField.layer.borderColor = CellStyle.shared.fieldBorderColor.cgColor
            break
        case .underline:
            let border = CALayer()
            border.borderColor = CellStyle.shared.fieldBorderColor.cgColor
            border.frame = CGRect(x: 0, y: textField.frame.size.height - CellStyle.shared.fieldBorderWidth, width: textField.frame.size.width, height: textField.frame.size.height)
            border.borderWidth = CellStyle.shared.fieldBorderWidth
            textField.layer.addSublayer(border)
            textField.layer.masksToBounds = true
            break
        }
        
        titleValueMarginContraint.constant = CellStyle.shared.titleSubTitleBottomMargin
        
        datePicker.addTarget(self, action: #selector(showDateAction(_:)), for: .valueChanged)
        self.textField.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 40))
        let flexibleSeparator = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        toolbar.items = [flexibleSeparator, doneButton]
        self.textField.inputAccessoryView = toolbar
    }

    func update(_ data: Data) {
        self.titleLabel.text = data.title
        datePicker.datePickerMode = data.mode
    }
    
    private func showDateChanged () {
     textField.text = DateFormatter.localizedString(from: datePicker.date, dateStyle: .medium, timeStyle: .medium)
        formDatePickerCellDelegate?.formDatePickerCell(self, date: datePicker.date)
    }
    
    @objc func showDateAction(_ sender: UIDatePicker) {
        showDateChanged()
    }
    
    @objc func doneButtonPressed() {
        textField.resignFirstResponder()
    }
}
