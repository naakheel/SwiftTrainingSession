//
//  NoteDetailViewController.swift
//  D3Notes
//
//  Created by Nabeel Ahamed on 7/14/21.
//

import UIKit

class NoteDetailViewController: UIViewController {

    var note: Note!
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var textDetails: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        lblTitle.text = note.title
        lblDate.text = dateFormatter.string(for: note.created)
        textDetails.text = note.details
    }
    

    @IBAction func doSaveNote(_ sender: Any) {
        note.details = textDetails.text
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
