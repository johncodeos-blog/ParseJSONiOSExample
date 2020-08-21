//
//  SimpleJSONModel.swift
//  ParseJSONSwiftyJSONExample
//
//  Created by John Codeos on 6/26/20.
//  Copyright © 2020 John Codeos. All rights reserved.
//

import Foundation

class SimpleJSONModel: Codable {
    let employee_id: String
    let employee_name: String
    let employee_salary: String
    let employee_age: String

    
    
    enum CodingKeys: String, CodingKey {
        case employee_id = "id"
        case employee_name
        case employee_salary
        case employee_age
    }
}
