//
//  DetailViewController.swift
//  2024-Line-Tech-Fresh-ios-App-Assessment
//
//  Created by LON Li on 2024/4/16.
//

import UIKit

class EpidemicDetailViewController: UIViewController{
    
    @IBOutlet weak var describeLabel: UILabel!

    var epidemic: Epidemic!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = epidemic.headline
        describeLabel.text = epidemic.description
        
    }
}
