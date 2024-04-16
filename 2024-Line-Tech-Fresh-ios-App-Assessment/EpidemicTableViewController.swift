//
//  EpidemicTableViewController.swift
//  2024-Line-Tech-Fresh-ios-App-Assessment
//
//  Created by LON Li on 2024/4/16.
//

import UIKit

class EpidemicTableViewController: UITableViewController {

    var epidemics = [Epidemic]()
    var refreshCon: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "國際重要疫情資訊"
        refreshCon = UIRefreshControl()
        refreshCon.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshCon)
        
        let urlStr = "https://www.cdc.gov.tw/TravelEpidemic/ExportJSON"
        
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, erroe) in
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                decoder.dateDecodingStrategy = .iso8601
                if let data = data {
                    do {
                        let ep = try decoder.decode([Epidemic].self, from: data)
                        self.epidemics = ep
                        DispatchQueue.main.async {
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
        return epidemics.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breakCell", for: indexPath) as! EpidemicTableViewCell

        let epidemic = epidemics[indexPath.row]
        cell.titleLabel.text = epidemic.headline
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let dateStr = formatter.string(from: epidemic.effective)
        cell.breakDayLabel.text = dateStr
        return cell
    }
    
    
    @IBSegueAction func ToEpidemicDetailPage(_ coder: NSCoder) -> EpidemicDetailViewController? {
        let controller =  EpidemicDetailViewController(coder: coder)
        if let row = tableView.indexPathForSelectedRow?.row {
            controller?.epidemic = epidemics[row]
            
        }
        return controller
    }
    
    @objc func refresh() {
        tableView.reloadData()
        refreshCon.endRefreshing()
    }
}
