import SwiftUI

struct AddNewListView: View {
    @ObservedObject private var controller: AddNewListController
    @Environment(\.dismiss) var dismiss
    
    init(controller: AddNewListController) {
        self.controller = controller
    }
    
    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Text("New List")
                    .font(.headline)
                    .padding(.bottom, 20)
                
                HStack {
                    Text("Name:")
                    TextField("", text: $controller.name)
                }
                
                HStack {
                    Text("Color:")
                    ColorListView(selectedColor: $controller.color)
                }
                
                HStack {
                    Spacer()
                    Button("Cancel") {
                        dismiss()
                    }
                    Button("OK") {
                        controller.save()
                        dismiss()
                    }
                    .disabled(controller.name.isEmpty)
                }
            }
            .frame(minWidth: 300)
            .padding(20)
        }
    }
}

#Preview {
    let viewContext = CoreDataManager.shared.persistentContainer.viewContext
    AddNewListView(controller: AddNewListController(context: viewContext))
}

