import SwiftUI

struct AddNewListView: View {
    @ObservedObject private var viewModel: AddNewListViewModel
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: AddNewListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Text("New List")
                    .font(.headline)
                    .padding(.bottom, 20)
                
                HStack {
                    Text("Name:")
                    TextField("", text: $viewModel.name)
                }
                
                HStack {
                    Text("Color:")
                    ColorListView(selectedColor: $viewModel.color)
                }
                
                HStack {
                    Spacer()
                    Button("Cancel") {
                        dismiss()
                    }
                    Button("OK") {
                        viewModel.save()
                        dismiss()
                    }
                    .disabled(viewModel.name.isEmpty)
                }
            }
            .frame(minWidth: 300)
            .padding(20)
        }
    }
}

#Preview {
    let viewContext = CoreDataManager.shared.persistentContainer.viewContext
    AddNewListView(viewModel: AddNewListViewModel(context: viewContext))
}

