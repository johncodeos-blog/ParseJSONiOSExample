//
//  SimpleJSONViewController.swift
//  ParseJSONExample
//
//  Created by John Codeos on 6/26/20.
//  Copyright © 2020 John Codeos. All rights reserved.
//

import UIKit

class SimpleJSONViewController: UIViewController {
    @IBOutlet var jsonResultsTextView: UITextView!
    @IBOutlet var parseJsonButton: UIButton!
    @IBOutlet var employeeIdLabel: UILabel!
    @IBOutlet var employeeNameLabel: UILabel!
    @IBOutlet var employeeSalaryLabel: UILabel!
    @IBOutlet var employeeAgeLabel: UILabel!
    
    var jsonData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Clean TextView
        jsonResultsTextView.text = ""
        // Clean Labels
        employeeIdLabel.text = ""
        employeeNameLabel.text = ""
        employeeSalaryLabel.text = ""
        employeeAgeLabel.text = ""
        
        // Get the JSON
        HttpRequestHelper().GET(url: "https://raw.githubusercontent.com/johncodeos-blog/ParseJSONiOSExample/master/simple.json") { success, data in
            if success {
                // Show JSON results in pretty form
                self.showPrettyJSON(jsonData: data!)
                
                self.jsonData = data
            } else {
                print("Error: Coudn't get the data")
            }
        }
    }
    
    @IBAction func parseJsonBtnAction(_ sender: UIButton) {
        // Check if jsonData exist
        if let data = jsonData {
            // Parse JSON
            self.parseJSON(jsonData: data)
        }
    }
    
    func showPrettyJSON(jsonData: Data) {
        let prettyResults = PrettyJSONHelper().convertPretty(data: jsonData)
        
        // Show Results in Main thread
        DispatchQueue.main.async {
            self.jsonResultsTextView.text = prettyResults ?? ""
        }
    }
    
    func parseJSON(jsonData: Data) {
        // JSONSerialization
        self.jsonSerialization(jsonData: jsonData)
        
        // JSONDecoder
        // self.jsonDecoder(jsonData: jsonData)
    }
    
    func jsonSerialization(jsonData: Data) {
        if let json = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] {
            // ID
            let id = json["id"] as? String ?? "N/A"
            print("ID: \(id)")
            employeeIdLabel.text = id
            
            // Employee Name
            let employeeName = json["employee_name"] as? String ?? "N/A"
            print("Employee Name: \(employeeName)")
            employeeNameLabel.text = employeeName
            
            // Employee Salary
            let employeeSalary = json["employee_salary"] as? String ?? "N/A"
            print("Employee Salaray: \(employeeSalary)")
            employeeSalaryLabel.text = "$ " + employeeSalary
            
            // Employee Age
            let employeeAge = json["employee_age"] as? String ?? "N/A"
            print("Employee Age: \(employeeAge)")
            employeeAgeLabel.text = employeeAge
        }
    }
    
    func jsonDecoder(jsonData: Data) {
        let jsondecode = try! JSONDecoder().decode(SimpleJSONModel.self, from: jsonData)
        
        // ID
        let id = jsondecode.employee_id
        print("ID: \(id)")
        employeeIdLabel.text = id
        
        // Employee Name
        let employeeName = jsondecode.employee_name
        print("Employee Name: \(employeeName)")
        employeeNameLabel.text = employeeName
        
        // Employee Salary
        let employeeSalary = jsondecode.employee_salary
        print("Employee Salary: \(employeeSalary)")
        employeeSalaryLabel.text = "$ " + employeeSalary
        
        // Employee Age
        let employeeAge = jsondecode.employee_age
        print("Employee Age: \(employeeAge)")
        employeeAgeLabel.text = employeeAge
    }
}





