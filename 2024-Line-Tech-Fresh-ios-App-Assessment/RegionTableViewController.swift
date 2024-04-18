//
//  RegionTableViewController.swift
//  2024-Line-Tech-Fresh-ios-App-Assessment
//
//  Created by LON Li on 2024/4/19.
//

import UIKit

class RegionTableViewController: UITableViewController {

    var regions = [Region]()
    var refreshCon: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "健保特約醫事機構-區域醫院"
        refreshCon = UIRefreshControl()
        refreshCon.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshCon)
        
        let urlStr = "https://info.nhi.gov.tw/api/iode0010/v1/rest/datastore/A21030000I-D21002-005"
        
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, erroe) in
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let responseData = try decoder.decode(RegionResponseData.self, from: data)
                        DispatchQueue.main.async {
                            self.regions = responseData.result.records.filter { $0.close.isEmpty }
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
        return regions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell", for: indexPath) as! RegionTableViewCell
        
        let region = regions[indexPath.row]
        cell.titleLabel.text = region.name
        
        return cell
    }
    
    @IBSegueAction func ToRegionDetailPage(_ coder: NSCoder) -> RegionDetailViewController? {
        let controller =  RegionDetailViewController(coder: coder)
        if let row = tableView.indexPathForSelectedRow?.row {
            controller?.region = regions[row]
        }
        return controller
    }
    
    @objc func refresh() {
        tableView.reloadData()
        refreshCon.endRefreshing()
    }
}

