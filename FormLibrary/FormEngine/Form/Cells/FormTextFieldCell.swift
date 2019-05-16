//
//  FormTextFieldCell.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/10/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//


import UIKit

protocol FormTextFieldCellDelegate {
    
    /** Called when the specified textfield text did change. */
    func formTextFieldCell(_ cell: FormTextFieldCell, updatedText: String?)
    
    /** Determines if the textfield should return. */
    func formTextFieldCellShouldReturn(_ cell: FormTextFieldCell, textField: UITextField) -> Bool
    
}

public class FormTextFieldCell: UICollectionViewCell, FormCell {
    
    public class Data: CellData {
        let title: String?
        let text: String?
        let placeholder: String?
        let keyboardType: UIKeyboardType
        let returnKeyType: UIReturnKeyType
        let formattingPattern: String?
        let capitalizationType: UITextAutocapitalizationType
        let isEditable: Bool
        let errorText: String?

        
        public init(title: String? = nil, text: String? = nil, placeholder: String? = nil, keyboardType: UIKeyboardType = .default, returnKeyType: UIReturnKeyType = .next, formattingPattern: String? = nil, capitalizationType: UITextAutocapitalizationType = .none, isEditable:Bool = true, errorText:String? = nil) {
            self.title = title
            self.text = text
            self.placeholder = placeholder
            self.keyboardType = keyboardType
            self.returnKeyType = returnKeyType
            self.formattingPattern = formattingPattern
            self.capitalizationType = capitalizationType
            self.isEditable = isEditable
            self.errorText = errorText
        }
    }
    
    //IBOutlets
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet var titleBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var textFieldHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var errorTopMarginConstraint: NSLayoutConstraint!
    
    //MARK: - Constants
    
    /* The text field horizontal inset */
    public static var textFieldInternalHorizontalInsets: CGFloat = 10
    
    public static var textFieldHeight: CGFloat = 44
    
    //Properties
    var delegate: FormTextFieldCellDelegate?
    
    /** Optional formatting pattern to be used for the cell. */
    fileprivate var formattingPattern: String?
    
    public static func getErrorHeight() -> CGFloat {
        return 31
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        
        self.titleLabel.textColor = CellStyle.shared.fieldTitleColor
        self.titleLabel.font = CellStyle.shared.fieldTitleFont
        self.titleBottomConstraint.constant = CellStyle.shared.fieldTitleBottomMargin
        
        textField.addTarget(self, action: #selector(onTextChange), for: .editingChanged)
        textField.delegate = self
        textField.backgroundColor = .white
        textField.textColor = CellStyle.shared.fieldEntryColor
        textField.tintColor = CellStyle.shared.fieldEntryColor
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: FormTextFieldCell.textFieldInternalHorizontalInsets, height: 0))
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: FormTextFieldCell.textFieldInternalHorizontalInsets, height: 0))
        textField.font = CellStyle.shared.fieldEntryFont
        textFieldHeightConstraint.constant = FormTextFieldCell.textFieldHeight
        
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
        
        errorLabel.textColor = CellStyle.shared.fieldErrorColor
        errorLabel.font = CellStyle.shared.fieldErrorFont
        errorTopMarginConstraint.constant = CellStyle.shared.errorTopMargin
    }
    
    @objc fileprivate func onTextChange() {
        if let formattingPattern = formattingPattern, let replacementText = textField.text, !replacementText.isEmpty {
            textField.text = replacementText.formatWithPattern(formattingPattern, replacementChar: "#".first!)
        }
        
        delegate?.formTextFieldCell(self, updatedText: textField.text)
    }
    
    /* update function */
    public func update(_ data: Data) {
        
        var title = data.title
        if title == nil || title?.count == 0 {
            title = " "
        }
        titleLabel.text = title
        textField.text = data.text
        
        if let placeholder = data.placeholder {
            let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : CellStyle.shared.fieldPlaceholderColor])
            textField.attributedPlaceholder = attributedPlaceholder
        }
        textField.keyboardType = data.keyboardType
        textField.autocapitalizationType = data.capitalizationType
        textField.returnKeyType = data.returnKeyType
        
        self.formattingPattern = data.formattingPattern
        
        textField.isUserInteractionEnabled = data.isEditable
        textField.layer.borderColor =  data.isEditable ? ((data.errorText != nil) ? CellStyle.shared.fieldErrorColor.cgColor :  CellStyle.shared.fieldBorderColor.cgColor ):  UIColor.white.cgColor
        textField.leftViewMode = data.isEditable ? .always : .never
        
        errorLabel.text = data.errorText
    }
    
    public override func prepareForReuse() {
        self.formattingPattern = nil
        textField.keyboardType = .default
        textField.autocapitalizationType = .none
        textField.placeholder = nil
        textField.text = nil
    }
    
    public func getTextField() -> UITextField {
        return textField
    }

}

extension FormTextFieldCell: UITextFieldDelegate {
    
    /** Determines if the textfield should return. */
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.formTextFieldCellShouldReturn(self, textField: textField) ?? false
    }
    
}
