//
//  IAPServices.swift
//  InAppPurchese
//
//  Created by Anil Kumar on 01/07/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import Foundation
import StoreKit

class IAPService: NSObject {
  
  private override init() {}
  static let shared = IAPService()
  
  var products = [SKProduct]()
  let paymentQueue = SKPaymentQueue.default()
  
  func getProducts(){
    let products: Set = [ IAPProduct.autoRenewingSubscription.rawValue,
                         IAPProduct.consumable.rawValue,
                         IAPProduct.nonConsumable.rawValue,
                         IAPProduct.nonAutoRenewingSubscription.rawValue
    ]
    let request = SKProductsRequest(productIdentifiers: products)
    request.delegate = self
    request.start()
    paymentQueue.add(self)
  }
  
  func purches(product: IAPProduct){
    guard let productToPurches = products.filter ({ $0.productIdentifier == product.rawValue}).first else { return }
    let payment = SKPayment(product: productToPurches)
    paymentQueue.add(payment)
  }
}

extension IAPService: SKProductsRequestDelegate {
  func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    print(response.products)
    for product in response.products {
      print(product.localizedTitle)
    }
  }
}

extension IAPService: SKPaymentTransactionObserver {
  func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    for transaction in transactions {
      print(transaction.transactionState)
      print(
        transaction.transactionState.state(),
        transaction.payment.productIdentifier
      )
      switch transaction.transactionState {
      case .purchased : break
      default : queue.finishTransaction(transaction)
      }
    }
  }
  
  func restorePurches(){
    print("restoring purches")
    paymentQueue.restoreCompletedTransactions()
  }
  
  
}


extension SKPaymentTransactionState{
  func state() -> String{
    switch self{
    case .deferred    : return "deferred"
    case .failed      : return "failed"
    case .purchased   : return "purchased"
    case .purchasing  : return "purchasing"
    case .restored    : return "restored"
    @unknown default:
      return "restore"
    }
  }
}
