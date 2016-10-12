//
//  HealthFinderFiltersViewController.swift
//  Assignment1
//
//  Created by Sherman Leung on 10/12/16.
//  Copyright © 2016 Sherman Leung. All rights reserved.
//

import UIKit

protocol HealthFinderFiltersViewControllerDelegate {
    func updateSearchFilters(gender: String, age:Int)
    func searchModeUsesFilters(usingFilters: Bool)
}

class HealthFinderFiltersViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var delegate:HealthFinderFiltersViewControllerDelegate?
    
    @IBOutlet var genderSegmentedControl: UISegmentedControl!
    @IBOutlet var agePickerView: UIPickerView!
    @IBOutlet var controlsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        agePickerView.delegate = self
    }
    
    @IBAction func searchModeDidChange(_ sender: UISwitch) {
        if (sender.isOn) {
            controlsView.isHidden = false
        } else {
            controlsView.isHidden = true
        }
        delegate?.searchModeUsesFilters(usingFilters: sender.isOn)
    }
    
    @IBAction func filtersDidChange(_ sender: AnyObject) {
        delegate?.updateSearchFilters(gender: genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex)!, age: agePickerView.selectedRow(inComponent: 0))
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 65
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        filtersDidChange(pickerView)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
