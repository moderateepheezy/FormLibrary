//
//  FormPasswordCell.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/10/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit


protocol FormPasswordCellDelegate {
    
    /** Called when the specified textfield text did change. */
    func formPasswordCell(_ cell: FormPasswordCell, updatedText: String?)
    
    /** Determines if the textfield should return. */
    func formPasswordCellShouldReturn(_ cell: FormPasswordCell, textField: UITextField) -> Bool
    
}

public class FormPasswordCell: UICollectionViewCell, FormCell {
    
    public class Data: CellData {
        let title: String
        let password: String
        let placeholder: String?
        
        public init(title: String, password: String, placeholder: String?) {
            self.title = title
            self.password = password
            self.placeholder = placeholder
        }
    }
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var showHideImageView: UIImageView!
    @IBOutlet var titleBottomConstraint: NSLayoutConstraint!
    
    var delegate: FormPasswordCellDelegate?
    private var showPassword = false
    
    private lazy var showImage: UIImage? = {
        return UIImage(named: "ic_show")?.withRenderingMode(.alwaysTemplate)
    }()
    
    private lazy var hideImage: UIImage? = {
        return UIImage(named: "ic_hide")?.withRenderingMode(.alwaysTemplate)
    }()

    override public func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = CellStyle.shared.fieldTitleColor
        titleLabel.font = CellStyle.shared.fieldTitleFont
        passwordTextField.textColor = CellStyle.shared.fieldEntryColor
        passwordTextField.font = CellStyle.shared.fieldEntryFont
        passwordTextField.backgroundColor = .white
        passwordTextField.addTarget(self, action: #selector(onTextChange), for: .editingChanged)
        passwordTextField.delegate = self
        passwordTextField.leftViewMode = .always
        passwordTextField.rightViewMode = .always
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passwordTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        showHideImageView.tintColor = CellStyle.shared.fieldBorderColor
        showHideImageView.image = hideImage
        
        switch (CellStyle.shared.textFieldStyle) {
        case .box:
            passwordTextField.layer.cornerRadius = CellStyle.shared.fieldCornerRadius
            passwordTextField.layer.borderWidth = CellStyle.shared.fieldBorderWidth
            passwordTextField.layer.borderColor = CellStyle.shared.fieldBorderColor.cgColor
            break
        case .underline:
            let border = CALayer()
            border.borderColor = CellStyle.shared.fieldBorderColor.cgColor
            border.frame = CGRect(x: 0, y: passwordTextField.frame.size.height - CellStyle.shared.fieldBorderWidth, width: passwordTextField.frame.size.width, height: passwordTextField.frame.size.height)
            border.borderWidth = CellStyle.shared.fieldBorderWidth
            passwordTextField.layer.addSublayer(border)
            passwordTextField.layer.masksToBounds = true
            break
        }
        
        titleBottomConstraint.constant = CellStyle.shared.fieldTitleBottomMargin
        
    }
    
    public func update(_ data: Data) {
        var title = data.title
        if title.count == 0 {
            title = " "
        }
        self.titleLabel.text = title
        if let placeholder = data.placeholder {
            let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : CellStyle.shared.fieldPlaceholderColor])
            self.passwordTextField.attributedPlaceholder = attributedPlaceholder
        }
        self.passwordTextField.text = data.password
    }
    
    @IBAction private func showPassword(_ sender: UIButton) {
        showPassword = !showPassword
        passwordTextField.isSecureTextEntry = !showPassword
        showHideImageView.image = showPassword ? showImage : hideImage
    }
    
    @objc fileprivate func onTextChange() {
        delegate?.formPasswordCell(self, updatedText: passwordTextField.text)
    }

}

extension FormPasswordCell: UITextFieldDelegate {
    
    /** Determines if the textfield should return. */
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.formPasswordCellShouldReturn(self, textField: passwordTextField) ?? false
    }
    
}
