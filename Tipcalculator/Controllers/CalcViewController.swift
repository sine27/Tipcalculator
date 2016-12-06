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
var percentagesPrint = [18, 20, 22]
var dividers = [1, 2, 3, 4]
var percent1 = Double(percentagesPrint[0]) / 100
var percent2 = Double(percentagesPrint[1]) / 100
var percent3 = Double(percentagesPrint[2]) / 100
var defaultPercentIndex : Int = 0

extension Double {
    var asLocaleCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from :NSNumber(value: self))!
    }
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
        
        percentSegmentController.setTitle("\(percentagesPrint[0])%", forSegmentAt: 0)
        percentSegmentController.setTitle("\(percentagesPrint[1])%", forSegmentAt: 1)
        percentSegmentController.setTitle("\(percentagesPrint[2])%", forSegmentAt: 2)
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onChange(_ sender: Any) {
        
        defaultPercentIndex = percentSegmentController.selectedSegmentIndex
        
        changeResult(percentIndex : defaultPercentIndex)
        
        if inputTextField.text != "" {
            
            self.inputToTop.constant = 0
            self.resultView.isHidden = false
            self.percentSegmentController.isHidden = false
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: { () -> Void in
                self.view.layoutIfNeeded()
                self.resultView.alpha = 1
                self.percentSegmentController.alpha = 1
            }, completion: nil)
            
        } else {
            self.inputToTop.constant = 80
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: { () -> Void in
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
            
            changeResult(percentIndex: defaultPercentIndex)
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
            
            changeResult(percentIndex: defaultPercentIndex)
        }
    }
    
    func changeResult (percentIndex : Int) {
        
        let percentageP = percentagesPrint[percentIndex]
        
        let percentage = Double(percentageP) / 100
        
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
        dividers = [1, 2, 3, 4]
        divider1.text = "\(dividers[0])"
        divider2.text = "\(dividers[1])"
        divider3.text = "\(dividers[2])"
        divider4.text = "\(dividers[3])"
        changeResult(percentIndex: defaultPercentIndex)
    }
    
    @IBAction func unwindToList(_ segue: UIStoryboardSegue) {
        
        if segue.identifier == "doneSetting" {

            let setController = segue.source as! SettingTableViewController
            let newpercentage = setController.defaultTipIndex
            if (newpercentage == nil) {
                changeResult(percentIndex: defaultPercentIndex)
            } else {
                percentSegmentController.selectedSegmentIndex = setController.percentageBar.selectedSegmentIndex
                
                if (setController.p1 > 100 || setController.p1 < 0) {
                    setController.p1 = percentagesPrint[0]
                } else {
                    percentagesPrint[0] = setController.p1
                    percent1 = Double(setController.p1 / 100)
                }
                if (setController.p2 > 100 || setController.p2 < 0) {
                    setController.p2 = percentagesPrint[1]
                } else {
                    percentagesPrint[1] = setController.p2
                    percent2 = Double(setController.p2 / 100)
                }
                if (setController.p3 > 100 || setController.p3 < 0) {
                    setController.p3 = percentagesPrint[2]
                } else {
                    percentagesPrint[2] = setController.p3
                    percent3 = Double(setController.p3 / 100)
                }
                
                percent1 = Double(percentagesPrint[0]) / 100
                percent2 = Double(percentagesPrint[1]) / 100
                percent3 = Double(percentagesPrint[2]) / 100
                
                percentSegmentController.setTitle("\(setController.p1)%", forSegmentAt: 0)
                percentSegmentController.setTitle("\(setController.p2)%", forSegmentAt: 1)
                percentSegmentController.setTitle("\(setController.p3)%", forSegmentAt: 2)
                changeResult(percentIndex: newpercentage!)
                
            }
        }
    }
}
