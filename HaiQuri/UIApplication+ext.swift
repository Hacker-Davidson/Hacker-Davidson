//
//  UIApplication+ext.swift
//  HaiQuri
//
//  Created by 櫻井絵理香 on 2024/03/10.
//

import Foundation
import UIKit
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
