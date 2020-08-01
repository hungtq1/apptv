//
//  TruyenSieuHayProducts.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/23/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import Foundation

public struct TruyenSieuHayProducts {
  
  public static let linhThach220 = "truyensieuhay.beblue.com.ipa.220"
  public static let linhThach450 = "truyensieuhay.beblue.com.ipa.450"
  private static let productIdentifiers: Set<ProductIdentifier> = [TruyenSieuHayProducts.linhThach220, TruyenSieuHayProducts.linhThach450]

  public static let store = IAPHelper(productIds: TruyenSieuHayProducts.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
  return productIdentifier.components(separatedBy: ".").last
}
