//
//  NestedJSONViewController.swift
//  ParseJSONExample
//
//  Created by John Codeos on 6/26/20.
//  Copyright © 2020 John Codeos. All rights reserved.
//

import UIKit

class NestedJSONViewController: UIViewController {
    @IBOutlet var jsonResultsTextView: UITextView!
    
    @IBOutlet var parseJsonButton: UIButton!
    @IBOutlet var jsonResultsTableView: UITableView!
    
    var employeeArray: [Datum] = [Datum]()
    
    var jsonData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView Customization
        jsonResultsTableView.separatorColor = .white
        jsonResultsTableView.separatorStyle = .singleLine
        jsonResultsTableView.tableFooterView = UIView()
        jsonResultsTableView.allowsSelection = false
        
        // Get the JSON
        HttpRequestHelper().GET(url: "https://raw.githubusercontent.com/johncodeos-blog/ParseJSONiOSExample/master/nested.json") { success, data in
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
    
    var employeeName: String!
    var employeeSalaryUSD: Int!
    var employeeSalaryEUR: Int!
    var employeeAge: String!
    
    func jsonSerialization(jsonData: Data) {
        let json = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
        
        if let data = json?["data"] as? [Any] {
            for item in data {
                if let object = item as? [String: Any] {
                    // ID
                    let id = object["id"] as? String ?? "N/A"
                    print("ID: \(id)")
                    
                    if let employee = object["employee"] as? [String: Any] {
                        // Employee Name
                        let employeeName = employee["name"] as? String ?? "N/A"
                        self.employeeName = employeeName
                        print("Employee Name: \(employeeName)")
                        
                        // Salary
                        if let salary = employee["salary"] as? [String: Any] {
                            // Employee Salary in USD
                            if let employeeSalaryUSD = salary["usd"] as? Int {
                                self.employeeSalaryUSD = employeeSalaryUSD
                                print("Employee Salary in USD: \(employeeSalaryUSD)")
                            }
                            
                            // Employee Salary in EUR
                            if let employeeSalaryEUR = salary["eur"] as? Int {
                                self.employeeSalaryEUR = employeeSalaryEUR
                                print("Employee Salary in EUR: \(employeeSalaryEUR)")
                            }
                        }
                        
                        // Employee Age
                        let employeeAge = employee["age"] as? String ?? "N/A"
                        self.employeeAge = employeeAge
                        print("Employee Age: \(employeeAge)")
                    }
                    
                    employeeArray.append(
                        Datum(employee_id: id, employee: Employee(name: employeeName ?? "N/A", salary: Salary(usd: employeeSalaryUSD ?? 0, eur: employeeSalaryEUR ?? 0), age: self.employeeAge))
                    )
                }
            }
            
            jsonResultsTableView.reloadData()
        }
    }
    
    func jsonDecoder(jsonData: Data) {
        let json = try! JSONDecoder().decode(NestedJSONModel.self, from: jsonData)
        
        let dataArray = json.data
        
        for item in dataArray {
            // ID
            let id = item.employee_id
            print("ID: \(id)")
            
            // Employee Name
            let employeeName = item.employee.name
            print("Employee Name: \(employeeName)")
            
            // Employee Salary in USD
            let employeeSalaryUSD = item.employee.salary.usd
            print("Employee Salaray USD: \(employeeSalaryUSD)")
            
            // Employee Salary in EUR
            let employeeSalaryEUR = item.employee.salary.eur
            print("Employee Salaray EUR: \(employeeSalaryEUR)")
            
            // Employee Age
            let employeeAge = item.employee.age
            print("Employee Age: \(employeeAge)")
            
            employeeArray.append(
                Datum(employee_id: id, employee: Employee(name: employeeName, salary: Salary(usd: employeeSalaryUSD, eur: employeeSalaryEUR), age: employeeAge))
            )
        }
        
        jsonResultsTableView.reloadData()
    }
}

extension NestedJSONViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "nestedjsoncellid", for: indexPath) as? NestedJSONCell else { fatalError("Cell not exists") }
        cell.employeeIdLabel.text = employeeArray[indexPath.row].employee_id
        cell.employeeNameLabel.text = employeeArray[indexPath.row].employee.name
        cell.employeeSalaryUSDLabel.text = "$ \(employeeArray[indexPath.row].employee.salary.usd)"
        cell.employeeSalaryEURLabel.text = "€ \(employeeArray[indexPath.row].employee.salary.eur)"
        cell.employeeAgeLabel.text = employeeArray[indexPath.row].employee.age
        return cell
    }
}

extension NestedJSONViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

