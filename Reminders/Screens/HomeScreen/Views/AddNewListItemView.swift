import SwiftUI

struct AddNewListItemView: View {
    
    @State private var title: String = ""
    @State private var dueDate: DueDate?
    
    var onSave: (String, Date?) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(systemName: Constants.Icons.circle)
                    .font(.system(size: 14))
                    .opacity(0.2)
                
                TextField("", text: $title)
            }
            
            Text("Notes")
                .opacity(0.2)
                .padding(.leading, 25)
            
            HStack {
                DueDateSelectionView(dueDate: $dueDate)
                
                if dueDate != nil {
                    Button("Clear") {
                        dueDate = nil
                    }
                }
                
                Button("Save") {
                    if !title.isEmpty {
                        onSave(title, dueDate?.value)
                        title = ""
                        dueDate = nil
                    }
                }
            }
            
        }.padding()
    }
}

#Preview {
    AddNewListItemView(onSave: {_, _ in })
}
