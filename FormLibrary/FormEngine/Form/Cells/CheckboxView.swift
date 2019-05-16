//
//  CheckboxView.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/10/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//


import UIKit

protocol CheckboxViewDelegate {
    func checkboxView(_ view: CheckboxView, checked: Bool)
}

class CheckboxView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var checkmarkImage: UIImageView!
    @IBOutlet var checkmarkBgView: UIView!
    
    private var checked: Bool = true
    public var delegate: CheckboxViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        Bundle(for: FormViewController.self).loadNibNamed("CheckboxView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        checkmarkBgView.layer.borderWidth = CellStyle.shared.fieldBorderWidth
        checkmarkBgView.layer.cornerRadius = CellStyle.shared.fieldCornerRadius
        checkmarkBgView.layer.borderColor = CellStyle.shared.fieldBorderColor.cgColor
        
        self.titleLabel.font = CellStyle.shared.fieldEntryFont
        self.checkmarkImage.image = UIImage(named: "ic_checkbox")
        
        updateCheckedState()
        
    }
    
    public func setChecked(_ checked: Bool) {
        
        self.checked = checked
        updateCheckedState()
        
    }
    
    private func updateCheckedState() {
        
        checkmarkImage.isHidden = !checked
        if checked {
            checkmarkBgView.backgroundColor = CellStyle.shared.fieldBorderColor
        } else {
            checkmarkBgView.backgroundColor = .white
        }
        
    }
    
    @IBAction func pressedCheckmark(_ button: UIButton) {
        
        self.checked = !checked
        updateCheckedState()
        delegate?.checkboxView(self, checked: self.checked)
        
    }

}
