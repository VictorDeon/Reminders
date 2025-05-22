import SwiftUI

struct DueDateSelectionView: View {
    
    @Binding var dueDate: DueDate?
    @State private var selectedDate: Date = Date.today
    @State private var showCalendar: Bool = false
    
    var body: some View {
        Menu {
            Button {
                dueDate = .today
            } label: {
                VStack {
                    Text("Today \n \(Date.today.formatAsString)")
                }
            }
            
            Button {
                dueDate = .tomorrow
            } label: {
                VStack {
                    Text("Tomorrow \n \(Date.tomorrow.formatAsString)")
                }
            }
            
            Button {
                dueDate = .yesterday
            } label: {
                VStack {
                    Text("Yesterday \n \(Date.yesterday.formatAsString)")
                }
            }
            
            Button {
                showCalendar = true
            } label: {
                Text("Custom Date")
            }
        } label: {
            Label(
                dueDate == nil ? "Add Due Date:" : dueDate!.title,
                systemImage: Constants.Icons.calendar
            )
        }
        .menuStyle(.borderedButton)
        .fixedSize()
        .popover(isPresented: $showCalendar, content: {
            DatePicker("Custom", selection: $selectedDate, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(.graphical)
                .onChange(of: selectedDate) { oldValue, newValue in
                    dueDate = .custom(newValue)
                    showCalendar = false
                }
        })
        .padding(5)
    }
}

#Preview {
    DueDateSelectionView(dueDate: .constant(nil))
}
