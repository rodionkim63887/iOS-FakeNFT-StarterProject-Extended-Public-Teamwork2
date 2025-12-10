import SwiftUI

struct SplashScreenView: View {
    @Environment(AppStartViewModel.self) var startVM

    var body: some View {
        ZStack {
            Color.whiteUniversalColor.ignoresSafeArea()
            Image("Image")
                .resizable()
                .scaledToFit()
                .frame(height: 75)
        }
        .padding(.top, -24)
        .overlay(alignment: .center) {
            ProgressView()
                .padding(.top, 150)
        }
        .task {
            if !startVM.isReady {
                await startVM.start()
            }
        }
        .networkErrorAlert(
            isPresented: Binding(
                get: { startVM.isError },
                set: { _ in startVM.isError = false }
            ),
            retry: {
                await startVM.retry()
            }
        )
    }
}
