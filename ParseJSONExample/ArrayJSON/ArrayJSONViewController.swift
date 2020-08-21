//
//  ArrayJSONViewController.swift
//  ParseJSONExample
//
//  Created by John Codeos on 6/26/20.
//  Copyright © 2020 John Codeos. All rights reserved.
//

import UIKit

class ArrayJSONViewController: UIViewController {
    @IBOutlet var jsonResultsTextView: UITextView!
    @IBOutlet var parseJsonButton: UIButton!
    
    @IBOutlet var jsonResultsTableView: UITableView!
    
    var employeeArray: [ArrayJSONModel] = [ArrayJSONModel]()
    
    var jsonData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TableView Customization
        jsonResultsTableView.separatorColor = .white
        jsonResultsTableView.separatorStyle = .singleLine
        jsonResultsTableView.tableFooterView = UIView()
        jsonResultsTableView.allowsSelection = false
        
        // Get the JSON
        HttpRequestHelper().GET(url: "https://raw.githubusercontent.com/johncodeos-blog/ParseJSONiOSExample/master/array.json") { success, data in
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
        let prettyResults = PrettyJSONHelper().convertPrettyArray(data: jsonData)
        
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
        if let json = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [Any] {
            for item in json {
                if let object = item as? [String: Any] {
                    // ID
                    let id = object["id"] as? String ?? "N/A"
                    print("ID: \(id)")
                    
                    // Employee Name
                    let employeeName = object["employee_name"] as? String ?? "N/A"
                    print("Employee Name: \(employeeName)")
                    
                    // Employee Salary
                    let employeeSalary = object["employee_salary"] as? String ?? "N/A"
                    print("Employee Salaray: \(employeeSalary)")
                    
                    // Employee Age
                    let employeeAge = object["employee_age"] as? String ?? "N/A"
                    print("Employee Age: \(employeeAge)")
                    
                    employeeArray.append(
                        ArrayJSONModel(
                            employee_id: id,
                            employee_name: employeeName,
                            employee_salary: "$ " + employeeSalary,
                            employee_age: employeeAge
                        )
                    )
                }
            }
            jsonResultsTableView.reloadData()
        }
    }
    
    func jsonDecoder(jsonData: Data) {
        let json = try! JSONDecoder().decode([ArrayJSONModel].self, from: jsonData)
        
        for item in json {
            // ID
            let id = item.employee_id
            print("ID: \(id)")
            
            // Employee Name
            let employeeName = item.employee_name
            print("Employee Name: \(employeeName)")
            
            // Employee Salary
            let employeeSalary = item.employee_salary
            print("Employee Salary: \(employeeSalary)")
            
            // Employee Age
            let employeeAge = item.employee_age
            print("Employee Age: \(employeeAge)")
            
            employeeArray.append(
                ArrayJSONModel(
                    employee_id: id,
                    employee_name: employeeName,
                    employee_salary: "$ " + employeeSalary,
                    employee_age: employeeAge
                )
            )
        }
        jsonResultsTableView.reloadData()
    }
}

extension ArrayJSONViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "arrayjsoncellid", for: indexPath) as? ArrayJSONCell else { fatalError("Cell not exists") }
        
        cell.employeeIdLabel.text = employeeArray[indexPath.row].employee_id
        cell.employeeNameLabel.text = employeeArray[indexPath.row].employee_name
        cell.employeeSalaryLabel.text = employeeArray[indexPath.row].employee_salary
        cell.employeeAgeLabel.text = employeeArray[indexPath.row].employee_age
        
        return cell
    }
}

extension ArrayJSONViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}



