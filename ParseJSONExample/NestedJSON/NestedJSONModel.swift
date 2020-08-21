//
//  NestedJSONModel.swift
//  ParseJSONExample
//
//  Created by John Codeos on 6/26/20.
//  Copyright © 2020 John Codeos. All rights reserved.
//

import Foundation

struct NestedJSONModel: Codable {
    let data: [Datum]

    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - Datum
struct Datum: Codable {
    let employee_id: String
    let employee: Employee

    enum CodingKeys: String, CodingKey {
        case employee_id = "id"
        case employee
    }
}

// MARK: - Employee
struct Employee: Codable {
    let name: String
    let salary: Salary
    let age: String

    enum CodingKeys: String, CodingKey {
        case name
        case salary
        case age
    }
}

// MARK: - Salary
struct Salary: Codable {
    let usd: Int
    let eur: Int

    enum CodingKeys: String, CodingKey {
        case usd
        case eur
    }
}
