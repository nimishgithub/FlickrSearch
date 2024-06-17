//
//  Accessibility+Extension.swift
//  FlickrSearch
//
//  Created by Nimish Sharma on 6/16/24.
//

import SwiftUI

extension View {
    func accessibilityConfig(label: String, hint: String? = nil) -> some View {
        self.accessibilityElement()
            .accessibility(label: Text(label))
            .ifLet(hint) { (view, unwrapped) in
                view
                    .accessibility(hint: Text(unwrapped))
            }
            
    }
}
