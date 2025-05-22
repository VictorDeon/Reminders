import SwiftUI

struct MyListItemsView: View {
    
    var items: [MyListItemController]
    
    typealias ItemAdded = ((String, Date?) -> Void)?
    typealias ItemDeleted = ((MyListItemController) -> Void)?
    typealias ItemCompleted = ((MyListItemController) -> Void)?
    
    var onItemAdded: ItemAdded
    var onItemDeleted: ItemDeleted
    var onItemCompleted: ItemCompleted
    
    init(items: [MyListItemController], onItemAdded: ItemAdded = nil, onItemDeleted: ItemDeleted = nil, onItemCompleted: ItemCompleted = nil) {
        self.items = items
        self.onItemAdded = onItemAdded
        self.onItemDeleted = onItemDeleted
        self.onItemCompleted = onItemCompleted
    }

    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(items, id: \.listItemId) { item in
                    ListItemCell(
                        item: item,
                        onListItemDeleted: { item in onItemDeleted?(item) },
                        onListItemCompleted: { item in onItemCompleted?(item) }
                    )
                }
                
                AddNewListItemView { title, dueDate in
                    onItemAdded?(title, dueDate)
                }
            }
        }
    }
}

#Preview {
    MyListItemsView(items: [])
}
