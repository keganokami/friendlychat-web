//
//  Copyright (c) 2015 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit

import FirebaseDatabase
import FirebaseApp
import FirebaseAuth
import Firebase.AdMob
import Firebase.Config
import Firebase.Core
import Firebase.CrashReporting

@objc(FCViewController)
class FCViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

  // Instance variables
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var sendButton: UIButton!
  var ref: Firebase!
  var messages: [FDataSnapshot]! = []
  var msglength: NSNumber = 10
  private var _refHandle: FirebaseHandle!
  private var userInt: UInt32 = arc4random()

  @IBOutlet weak var banner: GADBannerView!
  @IBOutlet weak var clientTable: UITableView!

  @IBAction func didSendMessage(sender: UIButton) {
    textFieldShouldReturn(textField)
  }

  @IBAction func didPressCrash(sender: AnyObject) {
    fatalError()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    loadAd()
    self.clientTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
    fetchConfig()
  }

  func loadAd() {
  }

  func fetchConfig() {
  }

  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text else { return true }

    let newLength = text.utf16.count + string.utf16.count - range.length
    return newLength <= self.msglength.integerValue // Bool
  }

  override func viewWillAppear(animated: Bool) {
  }

  override func viewWillDisappear(animated: Bool) {
  }

  // UITableViewDataSource protocol methods
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // Dequeue cell
    let cell: UITableViewCell! = self.clientTable.dequeueReusableCellWithIdentifier("tableViewCell", forIndexPath: indexPath)

    return cell!
  }

  // UITextViewDelegate protocol methods
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    return true
  }

  @IBAction func signOut(sender: UIButton) {
    AppState.sharedInstance.signedIn = false
    performSegueWithIdentifier(Constants.Segues.FpToSignIn, sender: nil)
  }

  func showAlert(title:String, message:String) {
    dispatch_async(dispatch_get_main_queue()) {
        let alert = UIAlertController(title: title,
            message: message, preferredStyle: .Alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .Destructive, handler: nil)
        alert.addAction(dismissAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
  }

}
