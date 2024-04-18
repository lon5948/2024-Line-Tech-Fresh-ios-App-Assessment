//
//  CenterTableViewController.swift
//  2024-Line-Tech-Fresh-ios-App-Assessment
//
//  Created by LON Li on 2024/4/19.
//

import UIKit

class CenterTableViewController: UITableViewController {

    var centers = [Center]()
    var refreshCon: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "健保特約醫事機構-醫學中心"
        refreshCon = UIRefreshControl()
        refreshCon.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshCon)
        
        let urlStr = "https://info.nhi.gov.tw/api/iode0010/v1/rest/datastore/A21030000I-D21001-003"
        
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, erroe) in
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let responseData = try decoder.decode(CenterResponseData.self, from: data)
                        DispatchQueue.main.async {
                            self.centers = responseData.result.records.filter { $0.close.isEmpty }
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
        return centers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell", for: indexPath) as! CenterTableViewCell
        
        let center = centers[indexPath.row]
        cell.titleLabel.text = center.name
        
        return cell
    }
    
    @IBSegueAction func ToCenterDetailPage(_ coder: NSCoder) -> CenterDetailViewController? {
        let controller =  CenterDetailViewController(coder: coder)
        if let row = tableView.indexPathForSelectedRow?.row {
            controller?.center = centers[row]
        }
        return controller
    }
    
    @objc func refresh() {
        tableView.reloadData()
        refreshCon.endRefreshing()
    }
}

