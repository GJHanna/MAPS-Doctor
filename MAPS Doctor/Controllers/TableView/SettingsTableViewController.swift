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

class SettingsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.item{
        case 0:
            self.performSegue(withIdentifier: "accountInfoSegue", sender: self)
            break
        case 1:
            self.logOutAlertView()
        default:
            break
        }
    }
    
    func logOutAlertView(){
        let alertController = UIAlertController(title: "Log-Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            FirebaseManager.logOutUser(completionHandler: {
                self.performSegue(withIdentifier: "fromLogOutToSignIn", sender: self)
            })
            self.dismiss(animated: true, completion: nil)
        })
        
        let decline = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alertController.addAction(confirm)
        alertController.addAction(decline)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
