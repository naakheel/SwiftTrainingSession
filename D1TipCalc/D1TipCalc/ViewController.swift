//
//  ViewController.swift
//  D1TipCalc
//
//  Created by Nabeel Ahamed on 7/12/21.
//

import UIKit

class TipCalc {
    func calcTipAmt(billAmount: Double, tipPercentage: Double) -> Double {
        return billAmount * (tipPercentage/100)
    }
    func calcTipTotal(billAmount: Double, tipPercentage: Double) -> (tip: Double, total: Double) {
        let tip = billAmount * (tipPercentage/100)
        return (tip, tip + billAmount)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var tfBillAmount: UITextField!
    @IBOutlet weak var lbTipValue: UILabel!
    @IBOutlet weak var lbTotalValue: UILabel!
    
    let numberFormatter = NumberFormatter()
    
    var tipPercentage = 10.0;
    var billAmount = 0.0;
    
    var tipPercList : [String] = ["20%", "10%", "25%", "15%"]
    var tipPercDict : [String:Double] = ["10%": 10.0, "25%":25.0, "20%":20.0, "15%": 15.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberFormatter.numberStyle = .currency
        tfBillAmount.becomeFirstResponder()
        
        // Learn Array
        print (tipPercList[2])
        tipPercList.append("12%")
        print (tipPercList.first ?? "")
        print (tipPercList.last ?? "")
        let sorted = tipPercList.sorted();
        print (sorted)
        
        // Learn Dictionary
        print (tipPercDict)
        tipPercDict["12%"] = 12.0
        for tup in tipPercDict {
            print (tup)
            print (tup.key)
            print (tup.value)
            print (tipPercDict[tup.key] ?? "")
        }
        
        let keys: [String] = Array(tipPercDict.keys)
        
        let scTipPerc = UISegmentedControl(items: keys.sorted())
        scTipPerc.selectedSegmentIndex = 0
        var frame : CGRect = tfBillAmount.frame
        frame.origin.y = frame.size.height + 175
        scTipPerc.frame = frame
        view.addSubview(scTipPerc)
        
        scTipPerc.addTarget(self, action: #selector(sgOnValueChange(_:)), for: .valueChanged)
        
    }


    func tfAmountToDouble() -> Double {
        let amtInString = tfBillAmount.text ?? "0.0"
        let amtInDouble = Double(amtInString) ?? 0.0
        return amtInDouble
    }
    
//    func scTipPercentageToDouble() -> Double {
//        let selectedIndx = scTipPercentage.selectedSegmentIndex
//        let tipPercentageInDouble = (Double(selectedIndx) * 5.0) + 10.0
//        return tipPercentageInDouble
//    }
    
    func updateTipTotalDisplay() {
        if (!billAmount.isLessThanOrEqualTo(0.0)) {
//            let tipValue = TipCalc().calcTipAmt(billAmount: billAmount, tipPercentage: tipPercentage)
            let bill = TipCalc().calcTipTotal(billAmount: billAmount, tipPercentage: tipPercentage)
//            lbTipValue.text = numberFormatter.string(for: tipValue)
//            lbTotalValue.text =  numberFormatter.string(for: billAmount + tipValue)
            lbTipValue.text = numberFormatter.string(for: bill.tip)
            lbTotalValue.text =  numberFormatter.string(for: bill.total)
        } else {
            lbTipValue.text = ""
            lbTotalValue.text = ""
        }
    }
    
    @IBAction func tfInputEditChanged(_ sender: Any) {
        billAmount = tfAmountToDouble();
        updateTipTotalDisplay()
    }
    
    @IBAction func sgOnValueChange(_ scTipPercentage: UISegmentedControl) {
//        tipPercentage = scTipPercentageToDouble()
        let selectedIndx = scTipPercentage.selectedSegmentIndex
        let title = scTipPercentage.titleForSegment(at: selectedIndx) ?? "10%"
        tipPercentage = tipPercDict[title] ?? 0.0
        updateTipTotalDisplay()
    }
}

