//
//  NestedJSONCell.swift
//  ParseJSONExample
//
//  Created by John Codeos on 6/26/20.
//  Copyright © 2020 John Codeos. All rights reserved.
//

import UIKit

class NestedJSONCell: UITableViewCell {
    @IBOutlet var employeeIdLabel: UILabel!
    @IBOutlet var employeeNameLabel: UILabel!
    @IBOutlet var employeeSalaryUSDLabel: UILabel!
    @IBOutlet var employeeSalaryEURLabel: UILabel!
    @IBOutlet var employeeAgeLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        employeeIdLabel.text = ""
        employeeNameLabel.text = ""
        employeeSalaryUSDLabel.text = ""
        employeeSalaryEURLabel.text = ""
        employeeAgeLabel.text = ""
    }
}
