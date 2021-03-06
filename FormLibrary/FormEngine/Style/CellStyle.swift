//
//  CellStyle.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/10/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit

public class CellStyle: NSObject {
    
    public static let shared = CellStyle()
    
    
    //MARK: - Colors
    public var fieldTitleColor: UIColor = .black
    public var fieldEntryColor: UIColor = .black
    public var fieldPlaceholderColor: UIColor = .black
    public var fieldBorderColor: UIColor = .black
    public var fieldErrorColor: UIColor = .black
    public var fieldDisabledColor: UIColor = .black
    
    public var buttonLabelColor: UIColor = .black
    
    public var sectionTitleColor: UIColor = .black
    public var titleColor: UIColor = .black
    public var subTitleColor: UIColor = .black
    
    
    //MARK: - Fonts
    public var fieldTitleFont: UIFont = {
        return .systemFont(ofSize: UIFont.systemFontSize)
    }()
    public var fieldEntryFont: UIFont = {
        return .systemFont(ofSize: UIFont.systemFontSize)
    }()
    public var fieldPlaceholderFont: UIFont = {
        return .systemFont(ofSize: UIFont.systemFontSize)
    }()
    public var fieldErrorFont: UIFont = {
        return .systemFont(ofSize: UIFont.systemFontSize)
    }()
    public var buttonLabelFont: UIFont = {
        return .systemFont(ofSize: UIFont.systemFontSize)
    }()
    public var sectionTitleFont: UIFont = {
        return .systemFont(ofSize: UIFont.systemFontSize)
    }()
    public var fieldButtonFont: UIFont = {
        return .systemFont(ofSize: UIFont.systemFontSize)
    }()
    public var titleFont: UIFont = {
        return .systemFont(ofSize: UIFont.systemFontSize)
    }()
    public var subTitleFont: UIFont = {
        return .systemFont(ofSize: UIFont.systemFontSize)
    }()
    public var checkboxFont: UIFont = {
        return .systemFont(ofSize: UIFont.systemFontSize)
    }()
    
    //MARK: - Sizes, Margins
    public var leadingMargin: CGFloat = 0
    public var trailingMargin: CGFloat = 0
    public var topMargin: CGFloat = 0
    public var bottomMargin: CGFloat = 0
    public func setFormMargins(leading: CGFloat, trailing: CGFloat, top: CGFloat, bottom: CGFloat) {
        leadingMargin = leading; trailingMargin = trailing; topMargin = top; bottomMargin = bottom;
    }
    
    
    //MARK: - Fields
    
    public var interItemFieldSpacing: CGFloat = 0
    public var lineSpacing: CGFloat = 1
    public var fieldCornerRadius: CGFloat = 0
    public var fieldBorderWidth: CGFloat = 1
    public var fieldTitleBottomMargin: CGFloat = 0
    public var sectionTitleTopMargin: CGFloat = 0
    public var sectionTitleBottomMargin: CGFloat = 0
    public var checkboxItemSpacing: CGFloat = 0
    public var titleSubTitleTopMargin: CGFloat = 0
    public var titleSubTitleBottomMargin: CGFloat = 0
    public var titleSubTitleVerticalSpacing: CGFloat = 0
    public var errorTopMargin: CGFloat = 0
    
    public enum TextFieldStyle {
        case box
        case underline
    }
    public var textFieldStyle: TextFieldStyle = .box
    public var bounce: Bool = false
    
    //MARK: - init
    private override init() {
        
    }

}
