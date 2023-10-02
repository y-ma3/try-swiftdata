import SwiftUI

@main
struct TrySwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Task.self)
        }
    }
}
