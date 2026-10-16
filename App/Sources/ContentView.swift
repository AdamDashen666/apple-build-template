import SwiftUI

struct ContentView: View {
    @State private var counter = Counter()

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "apple.logo")
                .font(.system(size: 56))
            Text("Hello from GitHub Actions")
                .font(.title2.bold())
            Text("\(counter.value)")
                .font(.system(size: 64, weight: .semibold, design: .rounded))
                .monospacedDigit()
            HStack(spacing: 16) {
                Button("−") { counter.decrement() }
                Button("+") { counter.increment() }
            }
            .buttonStyle(.borderedProminent)
            .font(.title)
            Text(Platform.name)
                .foregroundStyle(.secondary)
        }
        .padding(32)
        .frame(minWidth: 320, minHeight: 420)
    }
}

enum Platform {
    static var name: String {
        #if os(iOS)
        return UIDevice.current.userInterfaceIdiom == .pad ? "iPadOS" : "iOS"
        #elseif os(macOS)
        return "macOS"
        #else
        return "Apple"
        #endif
    }
}
