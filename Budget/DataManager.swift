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

class DataManager: NSObject {
  let database = SQLiteDatabase()


  let dailyBudget = NSDecimalNumber(string: "10.00")
  var spent = NSDecimalNumber(string: "0.00")
  
  func budgetRemainingToday() -> NSDecimalNumber {
//    print("remaining Budget is \(dailyBudget)")
    
    return dailyBudget.subtracting(sumOfTodayTransactions())
    
//    return dailyBudget.subtracting(spent)
    
  }
  
  func spend(amount: NSDecimalNumber, time: Date) {
    spent = spent.adding(amount)
  }
  
  func openDatabase() {
    /*
    database.closeDatabase()
    try? database.openDatabase(name: "test-database.db")
    
    let cq = """
    SELECT id, amount, timestamp
    FROM transactions;
  """
    
    var arrayOfAllTransactions = [[String: String]]()
    do {
      arrayOfAllTransactions = try database.execute(complexQuery: cq)
      print(arrayOfAllTransactions.count)
    }
    catch let error {
      print("error \(error)")
    }
*/
  }//openDatabase
  
  func setupDatabase() {
    
    let isPreloaded = UserDefaults.standard.bool(forKey: "initial_data_added_to_database")
    if !isPreloaded {
      UserDefaults.standard.set(true, forKey: "initial_data_added_to_database")
    try? database.openDatabase(name: "test-database.db")
      addTablesToDatabase()
    }//IF
  }//setupDatabase
  
  func addTablesToDatabase() {
    //    try? database.openDatabase(name: "test-database.db")
    try? database.execute(simpleQuery: """
CREATE TABLE daily_budgets (
  id INTEGER PRIMARY KEY,
  amount NUMERIC
   );

CREATE TABLE transactions (
  id INTEGER PRIMARY KEY,
  amount NUMERIC,
  timestamp INTEGER
   );
""")
  }//addTablesToDatabase
  
  func createTransaction(amount:NSDecimalNumber, time:Int) {
    try? database.execute(simpleQuery: """
      INSERT INTO daily_budgets (amount)
      VALUES ('\(budgetRemainingToday())');
      
      INSERT INTO transactions (amount, timestamp)
      VALUES ('\(amount)', '\(time)');
      """)
  }
  
  func sumOfTodayTransactions()->(NSDecimalNumber) {
    database.closeDatabase()
    try? database.openDatabase(name: "test-database.db")
    
    let cq = """
    SELECT SUM(amount)
    FROM transactions
  WHERE date(timestamp, 'unixepoch') = date('now');
  """
    
    var arrayOfAllTransactions = [[String: String]]()
    do {
      arrayOfAllTransactions = try database.execute(complexQuery: cq)
      print(arrayOfAllTransactions)
      
    }
    catch let error {
      print("error \(error)")
    }
    
    let dict = arrayOfAllTransactions[0]
    let spentDollas = dict["SUM(amount)"]
    
    let amount = NSDecimalNumber(string: spentDollas)
    print(amount)
    
    
    
    
    return amount
    
  }//sumOfTodaysTransactions
  
  
  func allOfTodaysTransactions()->[[String:String]] {
    database.closeDatabase()
    try? database.openDatabase(name: "test-database.db")
    
    let cq = """
    SELECT amount, date(timestamp, 'unixepoch') AS date
    FROM transactions
  WHERE date(timestamp, 'unixepoch') = date('now')
  ORDER BY amount DESC;
  """
    
    var arrayOfAllTransactions = [[String: String]]()
    do {
      arrayOfAllTransactions = try database.execute(complexQuery: cq)
      print(arrayOfAllTransactions)
      
    }
    catch let error {
      print("error \(error)")
    }
    
    return arrayOfAllTransactions
    
  }//allOfTodaysTransactions
  
  
  func convertIntToDate(timeInt:Int)->[[String:String]] {
    database.closeDatabase()
    try? database.openDatabase(name: "test-database.db")
    
    let cq = """
    SELECT date(\(timeInt), 'unixepoch') AS date
    
  """
    
    var arrayOfAllTransactions = [[String: String]]()
    do {
      arrayOfAllTransactions = try database.execute(complexQuery: cq)
      print(arrayOfAllTransactions)
      
    }
    catch let error {
      print("error \(error)")
    }
    
    return arrayOfAllTransactions
  }//convertIntToDate
  

func transOnThatDay(date:Int)-> [[String: String]]{
  database.closeDatabase()
  try? database.openDatabase(name: "test-database.db")
  
  let cq = """
  SELECT amount, date(timestamp, 'unixepoch') AS date
    FROM transactions
  WHERE date(timestamp, 'unixepoch') = date(\(date), 'unixepoch')
  ORDER BY amount DESC;
  """
  
  var arrayOfAllTransactions = [[String: String]]()
  do {
    arrayOfAllTransactions = try database.execute(complexQuery: cq)
//    print(arrayOfAllTransactions)
    
  }
  catch let error {
    print("error \(error)")
  }
  
  return arrayOfAllTransactions
}//transOnThatDay

}
/*
 SELECT amount, date(timestamp, 'unixepoch') FROM transactions ORDER BY timestamp DESC, amount DESC */

/*"""
 SELECT *
 FROM transactions
 WHERE date(timestamp, 'unixepoch') = date('now')
 ORDER BY timestamp DESC, amount DESC;
 """*/
