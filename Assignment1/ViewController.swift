//
//  ViewController.swift
//  Assignment1
//
//  Created by Sherman Leung on 9/21/16.
//  Copyright © 2016 Sherman Leung. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var topics: [NSDictionary]?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 110.0;
        
        let url = URL(string: "https://healthfinder.gov/developer/MyHFSearch.json?api_key=demo_api_key&who=child&age=16&gender=male")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task = session.dataTask(with: request) { (dataOrNil, response, err) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    if let results = responseDictionary["Result"] as? NSDictionary {
                        print("response \(results["Topics"])")
                        self.topics = results["Topics"] as? [NSDictionary]
                        self.tableView.reloadData()
                    }
                }
            }
        }
        task.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let topics = topics {
            return topics.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "healthFinderTableViewCell") as! HealthFinderTableViewCell
        let topic = topics![indexPath.row]
        let url = URL(string: topic["ImageUrl"] as! String)
        cell.topicImage.setImageWith(url!)
        cell.topicTitle.text = topic["Title"] as? String
        cell.topicLastUpdated.text = topic["LastUpdate"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "section_segue", sender: tableView.cellForRow(at: indexPath))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "section_segue") {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let destinationVC = segue.destination as! HealthFinderDetailViewController
            destinationVC.sections = topics![indexPath!.row]["Sections"] as? [NSDictionary]
        }
    }
}

