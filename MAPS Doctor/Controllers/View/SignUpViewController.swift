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

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var firstNameTextField: UITextField?
    @IBOutlet weak var middleNameTextField: UITextField?
    @IBOutlet weak var lastNameTextField: UITextField?
    @IBOutlet weak var professionTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var confirmPasswordTextField: UITextField?
    
    @IBOutlet weak var genderPickerView: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.genderPickerView.delegate = self
        self.genderPickerView.dataSource = self
        
        self.pickerData = ["Male", "Female"]
    }
    
    @IBAction func signUpButton(_sender: UIButton){
        passwordTextField?.isSecureTextEntry = false
        if let firstName = firstNameTextField?.text, let middleName = middleNameTextField?.text,
            let lastName = lastNameTextField?.text,  let profession = professionTextField?.text,
            let email = emailTextField?.text, let password = passwordTextField?.text,
            let confirmPassword = confirmPasswordTextField?.text{
            
            let alertTitle: String = "Sign-Up"
            
            if (!(firstName.isValid() && middleName.isValid() && lastName.isValid() && profession.isValid())){
                self.showAlertView(message: "Please fill all fields correctly", title: alertTitle)
            }else if (!email.isValidEmail()){
                self.showAlertView(message: "Please enter a valid email", title: alertTitle)
            }else if (password.isEmpty){
                self.showAlertView(message: "Please enter a valid password", title: alertTitle)
            }else if (password != confirmPassword){
                self.showAlertView(message: "Password don't match", title: alertTitle)
            }else{
                let userKeys = UserKeys()
                let info: [String: String] = [
                    userKeys.email: email,
                    userKeys.password: password,
                    userKeys.firstName: firstName,
                    userKeys.middleName: middleName,
                    userKeys.lastName: lastName,
                    userKeys.profession: profession,
                    userKeys.gender: pickerData[genderPickerView.selectedRow(inComponent: 0)]
                ]
                let user = Doctor(info: info)
                passwordTextField?.isSecureTextEntry = true
                FirebaseManager.signUpUser(user: user) { [weak self] (message, succuss) in
                    if succuss{
                        self!.showAlertView(message: message, title: alertTitle) { () -> (Void) in
                            self!.performSegue(withIdentifier: "fromSignUpHomeSegue", sender: nil)
                        }
                    }else{
                        self!.showAlertView(message: message, title: alertTitle)
                    }
                }
            }
        }
    }
    
    func checkNameValidity(name: String) -> Bool{
        return ((name.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil) || (name == ""))
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }
}

