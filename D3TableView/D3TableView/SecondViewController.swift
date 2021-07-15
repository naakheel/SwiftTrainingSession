//
//  SecondViewController.swift
//  D3TableView
//
//  Created by Nabeel Ahamed on 7/14/21.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lblHeader: UILabel!
    
    var text = "Success!"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblHeader.text = text
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
