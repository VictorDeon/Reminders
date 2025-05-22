import SwiftUI

struct SideBarView: View {
    
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext

    var body: some View {
        VStack(alignment: .leading) {
            Text("All Items Count 10")

            MyListsView(viewModel: MyListsViewModel(context: context))

            Spacer()

            Button { isPresented = true } label: {
                HStack {
                    Image(systemName: Constants.Icons.plusCircle)
                    Text("Add List")
                }
            }
            .buttonStyle(.plain)
            .padding()

        }
        .sheet(isPresented: $isPresented) {
            AddNewListView(viewModel: AddNewListViewModel(context: context))
        }
    }
}

#Preview {
    SideBarView()
}
