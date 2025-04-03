//
//  LoadingView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 29/03/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(1.5)
        }
    }
}

#Preview {
    LoadingView()
}
