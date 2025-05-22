import SwiftUI

struct SideBarView: View {
    
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext

    var body: some View {
        VStack(alignment: .leading) {
            MyListsView(controller: MyListsController(context: context))

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
            AddNewListView(controller: AddNewListController(context: context))
        }
        .frame(minWidth: 200)
    }
}

#Preview {
    SideBarView()
}
