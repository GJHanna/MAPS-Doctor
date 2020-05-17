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

class UserInfoViewController: UIViewController {

    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var professionLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailVerifiedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseManager.getUserInfo { [weak self] (doctor) in
            self?.title = doctor.name()
            self?.genderLabel.text = "Gender: " + doctor.gender
            self?.professionLabel.text = "Profession: " + doctor.profession
            
            FirebaseManager.getUserEmail { [weak self](email) in
                self?.emailLabel.text = "Email: " + email
            }
            
            if FirebaseManager.isEmailVerified(){
                self?.emailVerifiedLabel.text = "Email Verified"
                self?.emailVerifiedLabel.textColor = .green
            }else{
                self?.emailVerifiedLabel.text = "EMAIL IS NOT VERIFIED"
                self?.emailVerifiedLabel.textColor = .red
            }
        }
    }
}
