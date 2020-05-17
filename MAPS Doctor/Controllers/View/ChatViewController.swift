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

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var conversationEntryBackgroundView: UIView!
    
    var patient: Patient = Patient()
    
    private var cKey: String = ""
    private var messages: [Message] = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.title = self.patient.name()
        
        self.listentoMessages()

        self.conversationEntryBackgroundView.layer.borderWidth = 1
        self.conversationEntryBackgroundView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let infoVC = segue.destination as? PatientAccountInfoViewController{
            infoVC.patient = self.patient
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BubbleTableViewCell
        cell.configure(message: self.messages[indexPath.row])
        return cell
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        if let message = self.messageTextField.text{
            if (message.isSendable()){
                FirebaseManager.updateChatMessages(at: cKey, with: message)
            }
        }
        self.messageTextField.text?.removeAll()
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    private func listentoMessages(){
        FirebaseManager.getCKey(patient: patient) { (key) in
            self.cKey = key
            
            FirebaseManager.listenChatMessages(at: self.cKey) { [weak self] (messages) in
                self!.messages.removeAll()
                self!.messages.append(contentsOf: messages)
                self!.tableView.reloadData()
                if (!self!.messages.isEmpty){
                    self!.scrollToBottom()
                }
            }
        }
    }
}
