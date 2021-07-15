//
//  ViewController.swift
//  D3Notes
//
//  Created by Nabeel Ahamed on 7/14/21.
//

import UIKit

class Note : Codable {
    var title: String = ""
    var details: String = ""
    var created = Date()
    init(t: String, d: String) {
        title = t
        details = d
    }
}

extension URL {
    
    func fetchImage(completion: @escaping (UIImage?) -> Void) {
        fetchData { data, error in
            guard let d = data, error == nil else { return }
            let img = UIImage(data: d)
            completion(img)
        }
    }
    
    func fetchString(completion: @escaping (String?) -> Void) {
        fetchData { data, error in
            guard let d = data, error == nil else { return }
            let str = String(data: d, encoding: .ascii)
            completion(str)
        }
    }
    
    func fetchData(completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: self) { (data, response, error) in
            completion(data, error)
        }
        task.resume()
    }
}

class NoteManager {
    static let shared = NoteManager()
    private init() {}
    var fileURL : URL {
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        url.appendPathComponent("notes.json")
        return url
    }
    func storeNotes(notes: [Note]) {
        let data = try? JSONEncoder().encode(notes)
        try? data?.write(to: fileURL)
    }
    func loadNotes() -> [Note] {
        guard let data = try? Data(contentsOf: fileURL) else { return [Note]()}
        return (try? JSONDecoder().decode([Note].self, from: data)) ?? [Note]()
    }
}

class ViewController: UIViewController {

    var notes: [Note] = []
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfDetails: UITextField!
    @IBOutlet weak var tableNotes: UITableView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var scSortBy: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        if let url = URL(string: "https://google.com/") {
//            url.fetchData()
            url.fetchString { str in
                print(str)
            }
        }
        
        if let url = URL(string: "https://apple.co/2FZdO9A") {
            // UI updates main thread
            url.fetchImage { img in
                DispatchQueue.main.async {
                    let iv = UIImageView.init(frame: self.view.frame)
                    iv.image = img
                    self.view.addSubview(iv)
                }
            }
        }
    }
    
    @IBAction func titleChanged(_ sender: UITextField) {        
        saveBtn.isEnabled = sender.text != ""
        saveBtn.backgroundColor = sender.text != "" ? UIColor(red: 49/255, green: 163/255, blue: 159/255, alpha: 1): .lightGray
    }
    
    @IBAction func doSaveNote(_ sender: Any) {
        saveNote()
    }
    
    
    func saveNote() {
        tfDetails.resignFirstResponder()
        guard let noteTitle = tfTitle.text else { return }
        guard let noteDetails = tfDetails.text else { return }
        if noteTitle == "" {
            return
        }
        notes.append(Note.init(t: noteTitle, d: noteDetails))
        tfTitle.text = ""
        tfDetails.text = ""
        saveBtn.isEnabled = false
        saveBtn.backgroundColor = .lightGray
        sortNotes()
    }
    
    func sortNotes() {
        notes.sort { n1, n2 in
            if scSortBy.selectedSegmentIndex == 1 {
                return n1.created > n2.created
            } else {
                return n1.title < n2.title
            }
        }
        tableNotes.reloadData()
    }
    
    @IBAction func scValueChanged(_ sender: Any) {
        sortNotes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        guard let vc = segue.destination as? NoteDetailViewController else { return }
        
        guard let indexPath = tableNotes.indexPathForSelectedRow else { return }
        
        let selectedNote = notes[indexPath.row]
        vc.note = selectedNote
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfTitle {
            tfDetails.becomeFirstResponder()
        }
        else if textField == tfDetails {
            saveNote()
        }
        return true
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        
        cell.textLabel?.text = "\(notes[indexPath.item].title)"
        cell.detailTextLabel?.text = "\(dateFormatter.string(for: notes[indexPath.item].created) ?? "")"
        
        return cell
    }
       
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete"){ action, view, handler in
            print ("Deleting...")
            self.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            handler(true)
        }
        let config = UISwipeActionsConfiguration.init(actions: [actionDelete])
        return config
    }
    
}

