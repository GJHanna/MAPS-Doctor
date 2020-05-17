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
import Charts

@objc(BarChartFormatter)
class ChartFormatter: NSObject, IAxisValueFormatter {
   
    private var dates: [String] = [String]()
    
    public init(dates: [String]) {
        self.dates = dates
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = dates[Int(value) % dates.count]
        let mdy = date.components(separatedBy: " ")
        let md = mdy[0].components(separatedBy: "-")
        let month = md[0]
        let day = md[1]
        
        switch month {
        case "01":
            return "Jan " + day
        case "02":
            return "Feb " + day
        case "03":
            return "Mar " + day
        case "04":
            return "Apr " + day
        case "05":
            return "May " + day
        case "06":
            return "Jun " + day
        case "07":
            return "Jul " + day
        case "08":
            return "Aug " + day
        case "09":
            return "Sep " + day
        case "10":
            return "Oct " + day
        case "11":
            return "Nov " + day
        default:
            return "Dec " + day
        }
    }
}
