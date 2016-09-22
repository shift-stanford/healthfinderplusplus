//
//  HealthFinderDetailViewController.swift
//  Assignment1
//
//  Created by Sherman Leung on 9/22/16.
//  Copyright © 2016 Sherman Leung. All rights reserved.
//

import UIKit

class HealthFinderDetailViewController: UIViewController {
    
    var sections:[NSDictionary]?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sectionTextLabel: UILabel!
    
    override func viewDidLoad() {
        if let sections = sections {
            titleLabel.text = sections[0]["Title"] as? String
            let htmlContent = sections[0]["Content"] as? String
            let attrStr = try! NSAttributedString(
                data: htmlContent!.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil)
            sectionTextLabel.attributedText = attrStr
        }
    }
}
