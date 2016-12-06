//
//  CalcViewController.swift
//  Tipcalculator
//
//  Created by Shayin Feng on 12/5/16.
//  Copyright © 2016 Shayin Feng. All rights reserved.
//

import UIKit

let screenHeight: CGFloat = UIScreen.main.bounds.height
let screenWidth: CGFloat = UIScreen.main.bounds.width
var currentPercentIndex : Int = 0
var percentageArrayToDisplay : [Int] = [1, 2, 3]

extension Double {
    var asLocaleCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from :NSNumber(value: self))!
    }
}

struct userPercentage {
    static let p1 = "first_percentage_displayed"
    static let p2 = "second_percentage_displayed"
    static let p3 = "third_percentage_displayed"
}

class CalcViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var percentSegmentController: UISegmentedControl!
    
    @IBOutlet weak var resultView: UIView!

    @IBOutlet weak var tipResultLabel: UILabel!
    
    @IBOutlet weak var resultLabel0: UILabel!
    @IBOutlet weak var resultLabel1: UILabel!
    @IBOutlet weak var resultLabel2: UILabel!
    @IBOutlet weak var resultLabel3: UILabel!
    
    @IBOutlet weak var divider1: UILabel!
    @IBOutlet weak var divider2: UILabel!
    @IBOutlet weak var divider3: UILabel!
    @IBOutlet weak var divider4: UILabel!
    @IBOutlet weak var inputToTop: NSLayoutConstraint!
    
    var dividers = [1, 2, 3, 4]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultView.alpha = 0
        resultView.isHidden = true
        percentSegmentController.alpha = 0
        percentSegmentController.isHidden = true
        inputToTop.constant = 80
        
        inputTextField.becomeFirstResponder()

        tipResultLabel.text = 0.0.asLocaleCurrency
        resultLabel0.text = 0.0.asLocaleCurrency
        resultLabel1.text = 0.0.asLocaleCurrency
        resultLabel2.text = 0.0.asLocaleCurrency
        resultLabel3.text = 0.0.asLocaleCurrency

        // change the value of all divider when "+", "-" tapped +- 4)
        divider1.text = "1"
        divider2.text = "2"
        divider3.text = "3"
        divider4.text = "4"
        
        
        // check and get userDefault value for pertage array
        
        if (defaults.object(forKey: userPercentage.p1) == nil) {
            percentageArrayToDisplay = [18, 20, 22]
            defaults.setValue(18, forKey: userPercentage.p1)
            defaults.setValue(20, forKey: userPercentage.p2)
            defaults.setValue(22, forKey: userPercentage.p3)
            defaults.synchronize()
        } else {
            percentageArrayToDisplay[0] = defaults.integer(forKey: userPercentage.p1)
            percentageArrayToDisplay[1] = defaults.integer(forKey: userPercentage.p2)
            percentageArrayToDisplay[2] = defaults.integer(forKey: userPercentage.p3)
        }
        
        percentSegmentController.setTitle("\(percentageArrayToDisplay[0])%", forSegmentAt: 0)
        percentSegmentController.setTitle("\(percentageArrayToDisplay[1])%", forSegmentAt: 1)
        percentSegmentController.setTitle("\(percentageArrayToDisplay[2])%", forSegmentAt: 2)
        
        if (defaults.object(forKey: "default_tipPercentage_Index") != nil) {
            currentPercentIndex = defaults.integer(forKey: "default_tipPercentage_Index")
        } else {
            defaults.set(0, forKey: "default_tipPercentage_Index")
        }
        percentSegmentController.selectedSegmentIndex = currentPercentIndex
    }
    
    // hide keyboard
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // whenever input textfield or segmentController tapped, change the value
    @IBAction func onChange(_ sender: Any) {
        
        currentPercentIndex = percentSegmentController.selectedSegmentIndex
        
        changeResult(segControllerIndex : currentPercentIndex)
        
        // animation
        if inputTextField.text != "" {
            
            self.inputToTop.constant = 0
            self.resultView.isHidden = false
            self.percentSegmentController.isHidden = false
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseIn, animations: { () -> Void in
                self.view.layoutIfNeeded()
                self.resultView.alpha = 1
                self.percentSegmentController.alpha = 1
            }, completion: nil)
            
        } else {
            self.inputToTop.constant = 80
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseIn, animations: { () -> Void in
                self.resultView.alpha = 0
                self.percentSegmentController.alpha = 0
                self.view.layoutIfNeeded()
            }, completion: { (Bool) -> Void in
                self.resultView.isHidden = true
                self.percentSegmentController.isHidden = true
            })
        }
    }
    
    @IBAction func increaseDivider(_ sender: Any) {
        if (dividers[0] < 50)
        {
            dividers[0] += 4
            dividers[1] += 4
            dividers[2] += 4
            dividers[3] += 4
            divider1.text = "\(dividers[0])"
            divider2.text = "\(dividers[1])"
            divider3.text = "\(dividers[2])"
            divider4.text = "\(dividers[3])"
            
            changeResult(segControllerIndex: currentPercentIndex)
        }
    }

    @IBAction func decreseDivider(_ sender: Any) {
        if (dividers[0] > 1)
        {
            dividers[0] -= 4
            dividers[1] -= 4
            dividers[2] -= 4
            dividers[3] -= 4
            divider1.text = "\(dividers[0])"
            divider2.text = "\(dividers[1])"
            divider3.text = "\(dividers[2])"
            divider4.text = "\(dividers[3])"
            
            changeResult(segControllerIndex: currentPercentIndex)
        }
    }
    
    func changeResult (segControllerIndex : Int) {
        
        let percentageInt = percentageArrayToDisplay[segControllerIndex]
        
        let percentage = Double(percentageInt) / 100
        
        let amountBeforeTip = NSString(string: inputTextField.text!).doubleValue
        
        let tipValue = amountBeforeTip * percentage
        
        let amountAfterTip = amountBeforeTip + tipValue
        
        tipResultLabel.text = tipValue.asLocaleCurrency
        
        resultLabel0.text = (amountAfterTip/Double(dividers[0])).asLocaleCurrency
        resultLabel1.text = (amountAfterTip/Double(dividers[1])).asLocaleCurrency
        resultLabel2.text = (amountAfterTip/Double(dividers[2])).asLocaleCurrency
        resultLabel3.text = (amountAfterTip/Double(dividers[3])).asLocaleCurrency
    }

    @IBAction func resetValue(_ sender: Any) {
        inputTextField.text = ""
        dividers = [1, 2, 3, 4]
        divider1.text = "\(dividers[0])"
        divider2.text = "\(dividers[1])"
        divider3.text = "\(dividers[2])"
        divider4.text = "\(dividers[3])"
        
        currentPercentIndex = defaults.integer(forKey: "default_tipPercentage_Index")
        percentSegmentController.selectedSegmentIndex = currentPercentIndex
        changeResult(segControllerIndex: currentPercentIndex)
    }
    
    @IBAction func unwindToList(_ segue: UIStoryboardSegue) {
        
        if segue.identifier == "doneSetting" {

            let settingController = segue.source as! SettingTableViewController
            let newpercentage = settingController.defaultTipIndex
            if (newpercentage == nil) {
                changeResult(segControllerIndex: currentPercentIndex)
            } else {
                
                let defaults = UserDefaults.standard
                defaults.set(newpercentage, forKey: "default_tipPercentage_Index")
                defaults.synchronize()
                print(defaults.integer(forKey: "default_tipPercentage_Index"))
                currentPercentIndex = newpercentage!
                
                percentSegmentController.selectedSegmentIndex = settingController.percentageBar.selectedSegmentIndex
                
                if (settingController.p1 > 100 || settingController.p1 < 0) {
                    settingController.p1 = percentageArrayToDisplay[0]
                } else {
                    percentageArrayToDisplay[0] = settingController.p1
                }
                if (settingController.p2 > 100 || settingController.p2 < 0) {
                    settingController.p2 = percentageArrayToDisplay[1]
                } else {
                    percentageArrayToDisplay[1] = settingController.p2
                }
                if (settingController.p3 > 100 || settingController.p3 < 0) {
                    settingController.p3 = percentageArrayToDisplay[2]
                } else {
                    percentageArrayToDisplay[2] = settingController.p3
                }
                
                // update user default
                defaults.setValue(percentageArrayToDisplay[0], forKey: userPercentage.p1)
                defaults.setValue(percentageArrayToDisplay[1], forKey: userPercentage.p2)
                defaults.setValue(percentageArrayToDisplay[2], forKey: userPercentage.p3)
                defaults.synchronize()
                
                // change segment controller value displayed
                percentSegmentController.setTitle("\(percentageArrayToDisplay[0])%", forSegmentAt: 0)
                percentSegmentController.setTitle("\(percentageArrayToDisplay[1])%", forSegmentAt: 1)
                percentSegmentController.setTitle("\(percentageArrayToDisplay[2])%", forSegmentAt: 2)
                
                changeResult(segControllerIndex: newpercentage!)
                
            }
        }
    }
}
