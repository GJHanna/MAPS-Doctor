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

class Message: NSObject{
    var owner: String
    var message: String
    var date: TimeInterval!
    
    init(info: [String: Any]) {
        self.owner = info["owner"] as! String
        self.message = info["message"] as! String
        self.date = (info["timeStamp"] as! TimeInterval)
    }
    
    init(owner: String, message: String, date: TimeInterval) {
        self.owner = owner
        self.message = message
        self.date = date
    }
    
    init(owner: String, message: String){
        self.owner = owner
        self.message = message
        self.date = NSDate().timeIntervalSince1970
    }
    
    func timeStamp() -> String{
        let timeStamp = Date(timeIntervalSince1970: self.date)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatterGet.string(from: timeStamp)
    }
    
    func dictionarize() -> [String: Any]{
        return [
            "owner": "Dr. " + owner,
            "message": self.message,
            "timeStamp": self.date!
        ]
    }
    
    func dictionarizeWithId() -> [String: Any]{
        return [
            "owner": self.owner,
            "message": self.message,
            "timeStamp": self.date!
        ]
    }
}
