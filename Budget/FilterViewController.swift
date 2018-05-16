// Copyright (c) 2017 Lighthouse Labs. All rights reserved.
// 
// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended, or marketed for pedagogical or
// instructional purposes related to programming, coding, application development,
// or information technology.  Permission for such use, copying, modification,
// merger, publication, distribution, sublicensing, creation of derivative works,
// or sale is expressly withheld.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var tableView: UITableView!
    
    
    
    let dataManager = DataManager()
  var transArray = [[String:String]]()
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

      print("printind date \(giveCurrentDate())")
     
      
      
      
    }//load
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return transArray.count
  }
  
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
    
    
    let thisDict = transArray[indexPath.row]
    //    print(thisDict["first_name"] as Any)
    cell.textLabel?.text = thisDict["amount"]
//    cell.lb2.text = thisDict["date"]
    
    
    
    return cell
  }



  func giveCurrentDate() ->Int {
    var array = [[String:String]]()
    let time = datePicker.date
    let intTime = Int(time.timeIntervalSince1970)
    
    
    return intTime
  }



    
    
    @IBAction func pickerChanged(_ sender: Any) {
        
        transArray = dataManager.transOnThatDay(date: giveCurrentDate())
        print(transArray)
      tableView.reloadData()
        
        
        
    }//pickerChanged
    









}//end
