//
//  ViewController.swift
//  InAppPurchese
//
//  Created by Anil Kumar on 01/07/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  
  var subscriptionTable = UITableView()
  
  let subscripArray = ["consumable",
                       "nonConsumable",
                       "autoRenewingSubscription",
                       "nonAutoRenewingSubscription"
                      ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
      IAPService.shared.getProducts()
    
    view.addSubview(subscriptionTable)
    
    subscriptionTable.translatesAutoresizingMaskIntoConstraints = false
    
    subscriptionTable.register(UITableViewCell.self, forCellReuseIdentifier: "SubscriptionCell")
    
    NSLayoutConstraint.activate([
      subscriptionTable.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 0),
      subscriptionTable.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 0),
      subscriptionTable.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 0),
      subscriptionTable.rightAnchor.constraint(equalToSystemSpacingAfter: view.rightAnchor, multiplier: 0)
      ])
    
    subscriptionTable.delegate = self
    subscriptionTable.dataSource = self
    
    print(subscripArray.count)
  }
  
  

}


extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return subscripArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionCell", for: indexPath)
    cell.textLabel?.text = subscripArray[indexPath.row]
    return cell
  }
}


extension ViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0: IAPService.shared.purches(product: .consumable)
    case 1: IAPService.shared.purches(product: .nonConsumable)
    case 2: IAPService.shared.purches(product: .autoRenewingSubscription)
    case 3: IAPService.shared.purches(product: .nonAutoRenewingSubscription)
    default:
      IAPService.shared.restorePurches()
    }
  }
}
