//
//  TableViewController.swift
//  valute parse
//
//  Created by Павел Тимофеев on 12.05.2021.
//

import UIKit
import Alamofire
import SwiftyJSON
class TableViewController: UITableViewController {
    var array = [String]()
    let url = "http://data.fixer.io/api/latest"
    let key = "98371253a513f2c59a1c2f03721e979c"
    let base = "EUR"
    let symbols = "EUR, USD, RUB, GBR, CHF, JPY, AED, CZK"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parameter = ["access_key": key,
                          "base": base,
                          "symbols": symbols
        ]
        
// MARK: - Get request for all valute "http://data.fixer.io/api/latest?access_key=98371253a513f2c59a1c2f03721e979c"
        getValute(url: url, parameters: parameter)
    }
    func getValute(url:String, parameters: [String:String]) {
        AF.request(url,method: .get,parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                self.title = "\(json["date"])"
                self.updatesValute(json: json)
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func updatesValute(json: JSON) {
        for (name, valute) in json["rates"] {
            let currentValute = "\(name)    \(valute)"
            array.append(currentValute)
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]

        return cell
    }
    



}
