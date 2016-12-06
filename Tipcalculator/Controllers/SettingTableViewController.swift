//
//  SettingTableViewController.swift
//  Tipcalculator
//
//  Created by Shayin Feng on 12/6/16.
//  Copyright © 2016 Shayin Feng. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var percentage1TextField: UITextField!
    @IBOutlet weak var percentage2TextField: UITextField!
    @IBOutlet weak var percentage3TextField: UITextField!
    @IBOutlet weak var percentageBar: UISegmentedControl!
    
    var defaultTipIndex : Int!
    var p1 = percentagesPrint[0]
    var p2 = percentagesPrint[1]
    var p3 = percentagesPrint[2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        percentage1TextField.text = "\(percentagesPrint[0])"
        percentage2TextField.text = "\(percentagesPrint[1])"
        percentage3TextField.text = "\(percentagesPrint[2])"
        percentageBar.setTitle("\(percentagesPrint[0])%", forSegmentAt: 0)
        percentageBar.setTitle("\(percentagesPrint[1])%", forSegmentAt: 1)
        percentageBar.setTitle("\(percentagesPrint[2])%", forSegmentAt: 2)
        
        defaultTipIndex = defaultPercentIndex
        percentageBar.selectedSegmentIndex = defaultPercentIndex
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func percentage1change(_ sender: Any) {
        if (percentage1TextField.text == "") {
            p1 = 0
        } else {
            p1 = Int(percentage1TextField.text!)!
        }
        percentageBar.setTitle("\(p1)%", forSegmentAt: 0)
    }
    
    @IBAction func percentage2change(_ sender: Any) {
        if (percentage2TextField.text == "") {
            p2 = 0
        } else {
            p2 = Int(percentage2TextField.text!)!
        }
        percentageBar.setTitle("\(p2)%", forSegmentAt: 1)
    }
    
    @IBAction func percentage3change(_ sender: Any) {
        if (percentage3TextField.text == "") {
            p3 = 0
        } else {
            p3 = Int(percentage3TextField.text!)!
        }
        percentageBar.setTitle("\(p3)%", forSegmentAt: 2)
    }
    
    
    @IBAction func defaultIndexTapped(_ sender: Any) {
        defaultTipIndex = percentageBar.selectedSegmentIndex
        let defaults = UserDefaults.standard
        defaults.set(defaultTipIndex, forKey: "default_tipPercentage_Index")
        defaults.synchronize()
    }
}
