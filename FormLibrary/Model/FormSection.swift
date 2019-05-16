//
//  FormSection.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/13/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation

struct FormSection: Codable {
    let label: String
    let elements: [FormElement]
}
