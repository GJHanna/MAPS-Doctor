/// Copyright (c) 2020 George Hanna
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sub-licensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.


import UIKit

class NotesTableViewController: UITableViewController {
    
    private let reuseIdentifier: String = "note"
    private var notes: [Message] = [Message]()
    public var patient: Patient = Patient()
    public var messageKind: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.messageKind.capitalizingFirstLetter()
        self.tableView.rowHeight = UITableView.automaticDimension
        
        FirebaseManager.getAll(what: self.messageKind, patient: patient) { [weak self] (messages) in
            if (self?.notes.count != 0){
                self?.notes.removeAll()
            }
            self?.notes.append(contentsOf: messages)
            self?.tableView.reloadData()
        }
    }
    
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add " + self.messageKind, message: "", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Enter " + self.messageKind.capitalizingFirstLetter() + " here..."
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            FirebaseManager.addNoteOrPrescription(messageKind: self.messageKind, patient: self.patient, message: (alert?.textFields![0].text!)!)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageTableViewCell
        cell.configure(with: notes[indexPath.row])
        return cell
    }
}
