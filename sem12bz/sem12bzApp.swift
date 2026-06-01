import SwiftUI
import SwiftData

@main
struct sem12bzApp: App {

    var container: ModelContainer = {
        let schema = Schema([Docente.self])
        let config = ModelConfiguration("Docentes", schema: schema)

        if let container = try? ModelContainer(for: schema, configurations: [config]) {
            return container
        }

        let url = config.url
        try? FileManager.default.removeItem(at: url)
        try? FileManager.default.removeItem(atPath: url.path + "-wal")
        try? FileManager.default.removeItem(atPath: url.path + "-shm")
        return try! ModelContainer(for: schema, configurations: [config])
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, Locale(identifier: "es"))
        }
        .modelContainer(container)
    }
}
