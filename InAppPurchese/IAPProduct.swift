//
//  IAPProduct.swift
//  InAppPurchese
//
//  Created by Anil Kumar on 01/07/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import Foundation
import UIKit

enum IAPProduct: String {
  case consumable                   =   "com.perfutilconsultingltd.InAppPurchese.MyConsumable"
  case nonConsumable                =   "com.perfutilconsultingltd.InAppPurchese.MyNonConsumable"
  case autoRenewingSubscription     =   "com.perfutilconsultingltd.InAppPurchese.MyAutoRenewingSubscription"
  case nonAutoRenewingSubscription  =   "com.perfutilconsultingltd.InAppPurchese.MyNonAutoRenewingSubscription"
}
