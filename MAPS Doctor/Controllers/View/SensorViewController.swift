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
import Charts

class SensorViewController: UIViewController {
    
    @IBOutlet weak var amBarChart: BarChartView!
    @IBOutlet weak var pmBarChart: BarChartView!
    
    public var patientId: String = ""
    public var sensor: String!
    
    private let noDataMessage: String = "NO DATA YET"
    private var chartDescription:  String = ""
    private var chartLabel: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.amChart()
            self.pmChart()
        }
    }
    
    private func config(){
        switch self.sensor {
        case "temperature":
            self.chartLabel = "Celsius"
            self.chartDescription = "Temperature"
            break
        case "heartRate":
            self.chartLabel = "BPM"
            self.chartDescription = "Heart Rate"
            break
        case "pressure":
            self.chartLabel = "mmHg"
            self.chartDescription = "Blood Pressure"
            break
        default:
            self.chartLabel = "mmol/L"
            self.chartDescription = "Glucose"
        }
    }
    
    private func amChart(){
        FirebaseManager.getLastSevenSensorValue(patientId: patientId, dayTime: "AM", sensor: self.sensor) { [weak self] (dates, data) in
            self!.amBarChart.chartDescription?.text = "AM"
            if (data.isEmpty){
                self!.amBarChart.noDataText = self!.noDataMessage
                self!.amBarChart.noDataTextColor = .black
            }else{
                self!.setChart(chart: self!.amBarChart, dates: dates, with: data, timeOfDay: "AM")
                self!.amBarChart.animate(xAxisDuration: 0.75, yAxisDuration: 1.5)
            }
        }
    }
    
    private func pmChart(){
        FirebaseManager.getLastSevenSensorValue(patientId: patientId,dayTime: "PM", sensor: self.sensor) { [weak self] (dates, data)  in
            self!.pmBarChart.chartDescription?.text = "PM"
            if (data.isEmpty){
                self!.pmBarChart.noDataText = self!.noDataMessage
                self!.pmBarChart.noDataTextColor = .black
            }else{
                self!.setChart(chart: self!.pmBarChart, dates: dates, with: data, timeOfDay: "PM")
                self!.pmBarChart.animate(xAxisDuration: 0.75, yAxisDuration: 1.5)
            }
        }
    }
    
    private func setChart(chart: BarChartView, dates: [String], with values: [Double], timeOfDay: String){
        chart.isUserInteractionEnabled = false
        chart.contentMode = .scaleAspectFit
        chart.rightAxis.drawLabelsEnabled = false
        chart.xAxis.labelPosition = .bottom
        chart.layer.borderWidth = 0.25
        
        var dataEntries: [BarChartDataEntry] = []
        
        let xAxis = XAxis()
        let chartFormatter = ChartFormatter(dates: dates)
        
        for i in 0..<values.count {
            let dataEntry = BarChartDataEntry(x: Double(i + 1), y: values[i])
            dataEntries.append(dataEntry)
            let _ = chartFormatter.stringForValue(Double(i), axis: xAxis)
        }
        
        xAxis.valueFormatter = chartFormatter
        xAxis.labelFont = .systemFont(ofSize: 10)
        chart.xAxis.valueFormatter = xAxis.valueFormatter
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: self.chartLabel)
        let chartData = BarChartData(dataSet: chartDataSet)

        chartData.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 15)!)
        chart.data = chartData
    }
}
