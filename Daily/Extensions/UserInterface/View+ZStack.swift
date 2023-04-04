//
//  View+ZStack.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-03.
//

import SwiftUI

extension View {

    func zStackAlignment(_ alignment: Alignment) -> some View {
        VStack {
            if alignment == .center || alignment.isBottom{
                Spacer(minLength: 0)
            }

            HStack {
                if alignment == .center || alignment.isTrailing {
                    Spacer(minLength: 0)
                }

                self

                if alignment == .center || alignment.isLeading {
                    Spacer(minLength: 0)
                }
            }

            if alignment == .center || alignment.isTop {
                Spacer(minLength: 0)
            }
        }
    }
}

extension Alignment {
    var isBottom: Bool {
        [.bottom, .bottomLeading, .bottomTrailing].contains(self)
    }

    var isTop: Bool {
        [.top, .topLeading, .topTrailing].contains(self)
    }

    var isLeading: Bool {
        [.leading, .topLeading, .bottomLeading].contains(self)
    }

    var isTrailing: Bool {
        [.trailing, .topTrailing, .bottomTrailing].contains(self)
    }
}
