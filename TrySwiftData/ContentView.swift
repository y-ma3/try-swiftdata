import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var tasks: [Task]
    
    @State private var timeFormatter = DateFormatter()

    @State private var taskName = ""
    @State private var time = Date()
    
    init() {
        UIDatePicker.appearance().minuteInterval = 15
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.locale = Locale(identifier: "ja_jp")
    }

    var body: some View {
        VStack {
            HStack {
                TextField("予定", text: $taskName)
                    .padding(8)
                    .border(.gray, width: 1)
                    .frame(width: 200)
                DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                    .labelsHidden()
            }

            HStack {
                Button(action: {
                    add(taskName: taskName, time: time)
                    taskName = ""
                }, label: {
                    Text("追加")
                })
                .padding(.trailing, 24)
            }
            .padding(.top, 12)

            Spacer()

            List {
                ForEach(tasks) { task in
                    HStack {
                        Image(systemName: task.isDone ? "checkmark.circle" : "circle")
                            .onTapGesture {
                                task.isDone.toggle()
                            }
                            .padding(.trailing, 10)
                        Text("\(task.name)")
                        Spacer()
                        Text("\(timeFormatter.string(from: task.time))")
                    }
                    .font(.title)
                    .padding()
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        delete(task: tasks[index])
                    }
                })
            }
        }
    }

    private func add(taskName: String, time: Date) {
        let data = Task(name: taskName, time: time)
        context.insert(data)
    }

    private func delete(task: Task) {
        context.delete(task)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Task.self)
}
