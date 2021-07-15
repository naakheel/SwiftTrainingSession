//
//  ViewController.swift
//  D1First
//
//  Created by Nabeel Ahamed on 7/12/21.
//

import UIKit

class TipCalc {
    var tipPercentage = 0.15
    let time : Date = Date()
    
    init(tp: Double) {
        tipPercentage = tp
    }
    
    func calcTip( amount: Double) -> Double {
        return amount * tipPercentage
    }
    func calcTipWithPercentage( amount: Double, tipPercentage: Double = 0.35) -> Double {
        return amount * tipPercentage
    }
}

class MyViewController: UIViewController {

    @IBOutlet weak var lblInfo: UILabel!
    
    @IBOutlet weak var lblDataFetchInfo: UILabel!
       
    @IBOutlet weak var lblForInput: UILabel!
    
    @IBOutlet weak var tfInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.lightGray
        print (self.view.frame)
                
        lblInfo.text = "Welcome, ready to fetch!"
        
        let tc = TipCalc(tp: 0.45)
        var tip = tc.calcTip(amount: 100)
        print (tip)
        print (tc.time)
        tip = tc.calcTipWithPercentage(amount: 100) // Will use default tip percentage
        print (tip)
        print (tc.time)
        tip = tc.calcTipWithPercentage(amount: 100, tipPercentage: 0.25) // Will use passed tip percentage
        print (tip)
        print (tc.time)
    }
    
    
    @IBAction func doBtnAction(_ sender: UIButton) {
                        
        sender.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.lblDataFetchInfo.text = "Data fetch complete..!!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.lblDataFetchInfo.text = ""
                sender.setTitle("Fetch data again", for: .normal)
                sender.isEnabled = true
            }
        }
    }
    @IBAction func sgControl(_ sender: UISegmentedControl) {
        
    }
    @IBAction func doBtnForInputAction(_ sender: UIButton) {
        lblForInput.text = tfInput.text
    }
    
}

