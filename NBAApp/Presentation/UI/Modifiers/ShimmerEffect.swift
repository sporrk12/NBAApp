//
//  ShimmerEffect.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 13/03/25.
//

import SwiftUI

struct ShimmerEffect: ViewModifier {
    let configuration: ShimmerEffectConfiguration
    @State private var moveTo: CGFloat = -0.7

    func body(content: Content) -> some View {
        content
            .redacted(reason: .placeholder)
            .overlay {
                GeometryReader { geometry in
                    let size: CGSize = geometry.size
                    let extraOffset: CGFloat = size.height / 2.5

                    Rectangle()
                        .fill(self.configuration.highlightColor)
                        .mask {
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            .white.opacity(0),
                                            self.configuration.highlightColor.opacity(self.configuration.highlightOpactity),
                                            .white.opacity(0)
                                        ],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .blur(radius: self.configuration.blurRadius)
                                .rotationEffect(.degrees(-70))
                                .offset(x: self.moveTo > 0 ? extraOffset * 3.8 : -extraOffset * 3.8)
                                .offset(x: size.width * self.moveTo)
                                .frame(width: size.width * 3.8, height: size.height * 3.8)
                        }
                }
            }
            .onAppear {
                self.moveTo = 0.7
            }
            .animation(.linear(duration: self.configuration.speed).repeatForever(autoreverses: false ), value: self.moveTo)
    }
}

struct ShimmerEffectConfiguration {
    var color: Color = .gray.opacity(0.6)
    var highlightColor: Color = .white
    var blurRadius: CGFloat = 5.0
    var highlightOpactity: CGFloat = 0.7
    var speed: CGFloat = 1.8
}
