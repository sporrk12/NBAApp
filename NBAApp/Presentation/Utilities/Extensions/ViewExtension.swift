//
//  ViewExtension.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 13/03/25.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func showShimmer(_ show: Bool, configuration: ShimmerEffectConfiguration? = nil) -> some View {
        if show {
            let configuration: ShimmerEffectConfiguration = configuration ?? .init()
            self.modifier(ShimmerEffect(configuration: configuration))
        } else {
            self
        }
    }
}
