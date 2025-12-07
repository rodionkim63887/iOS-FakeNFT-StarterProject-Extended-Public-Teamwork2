//
//  LoadingOverlay.swift
//
//  A reusable SwiftUI component that displays a small
//  loading card with a centered spinner.
//  Attach `.loadingOverlay(isPresented)` to any view
//  and control its visibility with a Boolean state.
//

import SwiftUI

struct LoadingOverlay: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.lightGreyColor)
                .frame(width: 82, height: 82)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5)
        }
    }
}

extension View {
    func loadingOverlay(_ isPresented: Bool) -> some View {
        ZStack {
            self
            
            if isPresented {
                LoadingOverlay()
            }
        }
        .transition(.opacity)
    }
}

#Preview {
    LoadingOverlay()
}
