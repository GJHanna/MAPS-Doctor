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

class HomePageCollectionViewController: UICollectionViewController {

    public var patient: Patient = Patient()
    
    private let reuseIdentifier: String = "homePageCell"
    private var messageKind: String = ""
    private var sensor: String = ""
    private var sensorViewTitle: String = ""
    
    private let data: [HomePageCellStruct] = [
        HomePageCellStruct(imageName: "pressure", text: "Blood Pressure"),
        HomePageCellStruct(imageName: "heartRate", text: "Heart Rate"),
        HomePageCellStruct(imageName: "sugarLevel", text: "Gluco Meter"),
        HomePageCellStruct(imageName: "temperature", text: "Temperature"),
        HomePageCellStruct(imageName: "pill", text: "Prescriptions"),
        HomePageCellStruct(imageName: "notebook", text: "Notes")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let itemSize = UIScreen.main.bounds.width / 2 - 5
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 2, bottom: 20, right: 2)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        self.collectionView.collectionViewLayout = layout
    }

    override func viewWillAppear(_ animated: Bool) {
        self.title = patient.name()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sensorVC = segue.destination as? SensorViewController{
            sensorVC.title = self.sensorViewTitle
            sensorVC.sensor = self.sensor
            sensorVC.patientId = self.patient.id
        }
        
        if let notesTVC = segue.destination as? NotesTableViewController{
            notesTVC.patient = self.patient
            notesTVC.messageKind = self.messageKind
        }
        
        if let chatVC = segue.destination as? ChatViewController{
            chatVC.patient = self.patient
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! HomePageCollectionViewCell
        cell.configure(with: data[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row == 4 || indexPath.row == 5){
            self.messageKind = data[indexPath.item].text.lowercased()
            self.performSegue(withIdentifier: "notesSegue", sender: self)
        }else{
            self.sensor = data[indexPath.item].imageName
            self.sensorViewTitle = data[indexPath.item].text
            self.performSegue(withIdentifier: "sensorSegue", sender: self)
        }
    }
}
