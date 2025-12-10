import SwiftUI

extension View {
    func networkErrorAlert(
        isPresented: Binding<Bool>,
        retry: @escaping () async -> Void
    ) -> some View {
        alert(
            "Не удалось получить данные",
            isPresented: isPresented
        ) {
            Button("Повторить") {
                Task { await retry() }
            }
            Button("Отмена", role: .cancel) {}
        }
    }
}
