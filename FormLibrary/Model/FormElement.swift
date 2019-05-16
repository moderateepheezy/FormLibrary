//
//  FormElement.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/13/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation

struct FormElement: Codable {
    let type: String
    let file: String?
    let uniqueID: String
    let rules: [FormRule]
    let label: String?
    let isMandatory: Bool?
    let keyboard, formattedNumeric, mode: String?
    
    enum CodingKeys: String, CodingKey {
        case type, file
        case uniqueID = "unique_id"
        case rules, label, isMandatory, keyboard, formattedNumeric, mode
    }
    
    var cellType: FormViewController.CellType {
        switch type {
        case "text", "formattednumeric":
            return .text
        case "yesno":
            return .buttonOptions
        case "embeddedphoto":
            return .photo
        case "datetime":
            return .date
        default:
            return .label
        }
    }
    
    var cellData: CellData {
        switch type {
        case "formattednumeric":
            return FormTextFieldCell.Data(title: label ?? "", text: "", placeholder: "0700- 123-1234", keyboardType: .numberPad, returnKeyType: .next, formattingPattern: formattedNumeric ?? "", capitalizationType: .none, isEditable: true)
        case "text":
            return FormTextFieldCell.Data(title: label ?? "", text: "", placeholder: "", keyboardType: .default, returnKeyType: .next, formattingPattern: nil, capitalizationType: .words, isEditable: true)
        case "yesno":
            return FormButtonOptionsCell.Data(title: label ?? "", multiSelect: false, options: ["Yes", "No"])
        case "datetime":
            return FormDatePickerCell.Data(title: label ?? "", mode: .dateAndTime)
        case "embeddedphoto":
            return FormPhotoCell.Data(imageUrl: file ?? "", imageHeight: 100)
        default:
            return FormLabelCell.Data(text: NSAttributedString(string: "I am a label!"))
        }
        
    }
}
