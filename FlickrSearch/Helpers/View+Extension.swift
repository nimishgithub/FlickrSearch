//
//  View+Extension.swift
//  FlickrSearch
//
//  Created by Nimish Sharma on 6/16/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func ifLet<T, Content: View>(_ value: T?, @ViewBuilder content: (Self, T) -> Content) -> some View {
        if let value = value {
            content(self, value)
        } else {
            self
        }
    }
}
