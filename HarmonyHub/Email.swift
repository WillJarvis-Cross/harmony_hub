//
//  EmailFunc.swift
//  HarmonyHub
//
//  Created by Namashi Sivaram on 2023-07-05.
//

import Foundation
func isValidEmail(_ strToValidate: String) -> Bool {
  let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"  // 1

  let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)  // 2

  return emailValidationPredicate.evaluate(with: strToValidate)  // 3
}
