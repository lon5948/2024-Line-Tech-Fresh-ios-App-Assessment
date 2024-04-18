//
//  DistrictTableViewController.swift
//  2024-Line-Tech-Fresh-ios-App-Assessment
//
//  Created by LON Li on 2024/4/18.
//

import UIKit

class DistrictTableViewController: UITableViewController {

    var districts = [District]()
    var refreshCon: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "健保特約醫事機構-地區醫院"
        refreshCon = UIRefreshControl()
        refreshCon.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshCon)
        
        let urlStr = "https://info.nhi.gov.tw/api/iode0010/v1/rest/datastore/A21030000I-D21003-003"
        
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, erroe) in
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let responseData = try decoder.decode(DistrictResponseData.self, from: data)
                        DispatchQueue.main.async {
                            self.districts = responseData.result.records.filter { $0.close.isEmpty }
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return districts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "districtCell", for: indexPath) as! DistrictTableViewCell
        
        let district = districts[indexPath.row]
        cell.titleLabel.text = district.name
        
        return cell
    }
    
    @IBSegueAction func ToDistrictDetailPage(_ coder: NSCoder) -> DistrictDetailViewController? {
        let controller =  DistrictDetailViewController(coder: coder)
        if let row = tableView.indexPathForSelectedRow?.row {
            controller?.district = districts[row]
        }
        return controller
    }
    
    @objc func refresh() {
        tableView.reloadData()
        refreshCon.endRefreshing()
    }
}
