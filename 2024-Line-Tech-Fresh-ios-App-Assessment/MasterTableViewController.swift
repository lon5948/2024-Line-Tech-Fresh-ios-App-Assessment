//
//  MasterTableViewController.swift
//  2024-Line-Tech-Fresh-ios-App-Assessment
//
//  Created by LON Li on 2024/4/18.
//

import UIKit

class MasterTableViewController: UITableViewController {

    let imageName: [String] = ["epidemic", "pharmacy", "clinic", "district", "regional", "center"]
    let buttonName: [String] = ["國際重要疫情資訊", "健保特約醫事機構-藥局", "健保特約醫事機構-診所", "健保特約醫事機構-地區醫院", "健保特約醫事機構-區域醫院", "健保特約醫事機構-醫學中心"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rootCell", for: indexPath)

        cell.imageView?.image = UIImage(named: self.imageName[indexPath.row])
        cell.textLabel?.text = self.buttonName[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
            case 0:
                performSegue(withIdentifier: "showEpidemicInfo", sender: self)
            case 1:
                performSegue(withIdentifier: "showPharmacy", sender: self)
            case 2:
                performSegue(withIdentifier: "showClinic", sender: self)
            case 3:
                performSegue(withIdentifier: "showDistrict", sender: self)
            default:
                break
        }
    }
}
