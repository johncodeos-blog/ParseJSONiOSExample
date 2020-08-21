//
//  ArrayJSONCell.swift
//  ParseJSONExample
//
//  Created by John Codeos on 6/26/20.
//  Copyright © 2020 John Codeos. All rights reserved.
//

import UIKit

class ArrayJSONCell: UITableViewCell {
    @IBOutlet var employeeIdLabel: UILabel!
    @IBOutlet var employeeNameLabel: UILabel!
    @IBOutlet var employeeSalaryLabel: UILabel!
    @IBOutlet var employeeAgeLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        employeeIdLabel.text = ""
        employeeNameLabel.text = ""
        employeeSalaryLabel.text = ""
        employeeAgeLabel.text = ""
    }
}
