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

class TransactionViewControllerclass: UIViewController {
  
  @IBOutlet weak var amountSpentTextField: UITextField!
  @IBOutlet weak var amountRemainingLabel: UILabel!
  @IBOutlet weak var datePicker: UIDatePicker!
  
  let dataManager = DataManager()
  let database = SQLiteDatabase()
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    try? database.openDatabase(name: "test-database.db")
    
    dataManager.openDatabase()
    updateRemainingLabel()
//    setupDatabase()

    dataManager.setupDatabase()
    dataManager.sumOfTodayTransactions()
    
    
    
    
  }
  
  func updateRemainingLabel() {
    amountRemainingLabel.text = "$\(dataManager.budgetRemainingToday().stringValue)"
  }
  
  @IBAction func spend(_ sender: Any) {
    guard let amountString = amountSpentTextField.text else {
      print("User needs to enter an amount")
      return
    }
    
    let amount = NSDecimalNumber(string: amountString)
    if amount == NSDecimalNumber.notANumber {
      alertUserToEnterAValidNumber()
      return
    }
    let time = datePicker.date
    
    print("Spent \(amountString) at \(time)")
    
    dataManager.spend(amount: amount, time: time)
    updateRemainingLabel()
    
    dataManager.createTransaction(amount: amount, time: Int(time.timeIntervalSince1970))
    
  }
  
  private func alertUserToEnterAValidNumber() {
    let alert = UIAlertController(title: "Error!", message: "Please enter a valid amount.", preferredStyle: .alert)
    let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  
  
  
  
 
  
}//end


/*
 try? database.execute(simpleQuery: """
 INSERT INTO daily_budgets (amount)
 VALUES ('amount');
 
 INSERT INTO transactions (amount, timestamp)
 VALUES ('amount', 'toad');
 
 
 """)
 
 */

