import Foundation
import SwiftData

@Model
class Task {
    var name: String
    var isDone: Bool
    let time: Date

    init(name: String, time: Date) {
        self.name = name
        isDone = false
        self.time = time
    }
}
