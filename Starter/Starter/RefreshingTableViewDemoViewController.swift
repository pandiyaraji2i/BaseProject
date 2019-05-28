//
//  RefreshingTableViewDemoViewController.swift
//  Starter
//
//  Created by ideas2it on 5/28/19.
//  Copyright © 2019 Durai-Ideas2IT. All rights reserved.
//

import UIKit

class RefreshingTableViewDemoViewController: UIViewController {
    
    @IBOutlet weak var tableView: IITableView!

    var usersList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserList()
        self.tableView.refreshControl?.addTarget(self, action: #selector(self.getUserList), for: .valueChanged)
    }
    
    
    @objc func getUserList() {
        self.usersList.removeAll()
        if NetworkUtilities.hasConnectivity() {
            NetworkUtilities.sendAsynchronousRequestToServer(actionName: URLConstants.getUsers, httpMethod: HttpMethod.GET, requestBody: nil, contentType: CommonValues.jsonApplication) { (jsonResponse) in
                
                if jsonResponse as? NSArray != nil {
                    if  let responseList = jsonResponse as? [[String : AnyObject]] {
                        print(responseList)
                        for responseDict in responseList {
                            self.usersList.append(responseDict["name"] as? String ?? "")
                        }
                        DispatchQueue.main.async {
                            self.tableView.refreshControl?.endRefreshing()
                            self.tableView.reloadData()
                            if self.usersList.count == 0 {
                                self.tableView.showEmptyLabel("No users found!")
                            } else {
                                self.tableView.hideEmptyLabel()
                            }
                        }
                    }
                } else {
                    self.showAlert(title: "Message", contentText: ErrorMessage.commonMessage, actions: nil)
                }
            }
        } else {
            self.showAlert(title: "Message", contentText: ErrorMessage.noInternetMessage, actions: nil)
        }
    }
    
}

extension RefreshingTableViewDemoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = self.usersList[indexPath.row]
        return cell
    }
}

