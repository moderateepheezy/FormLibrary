//
//  MockData.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/14/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation

class MockData {
    
    static func fetchForms() -> Form? {
        if let url = Bundle.main.url(forResource: "pet_adoption", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                return try JSONDecoder().decode(Form.self, from: jsonData)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    static func fetchPageOne() -> Page? {
        guard let form = fetchForms() else {return nil}
        return form.pages[2]
    }
}
