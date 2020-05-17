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


import Foundation

class BaseUser: NSObject {
    internal var email: String!
    internal var firstName: String!
    internal var middleName: String!
    internal var lastName: String!
    internal var gender: String!
    
    internal let key: UserKeys = UserKeys()
    
    override init() {}
    
    init(info: [String: Any]) {
        self.email = info[key.email] as? String
        self.firstName = info[key.firstName] as? String
        self.middleName = info[key.middleName] as? String
        self.lastName = info[key.lastName] as? String
        self.gender = info[key.gender] as? String
    }
    
    internal func capitalizeAll(){
        self.firstName.capitalizeFirstLetter()
        self.middleName.capitalizeFirstLetter()
        self.lastName.capitalizeFirstLetter()
        self.gender.capitalizeFirstLetter()
    }
    
    func name()  -> String{
        self.capitalizeAll()
        return self.firstName + " " + self.lastName
    }
    
    func fullName() -> String{
        self.capitalizeAll()
        return self.firstName + " " + self.middleName + " " + self.lastName
    }
}
