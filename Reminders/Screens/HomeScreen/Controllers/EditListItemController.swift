import Foundation

class EditListItemController: ObservableObject {
    var listItemController: MyListItemController
    
    @Published var title: String = ""
    @Published var selectedDate: Date?
    
    init(listItemController: MyListItemController) {
        self.listItemController = listItemController
        title = listItemController.title
        selectedDate = listItemController.dueDate?.value ?? nil
    }
    
    func save() {
        let myListItem: MyListItem? = MyListItem.byId(id: listItemController.listItemId)
        if let myListItem = myListItem {
            myListItem.title = title
            myListItem.dueDate = selectedDate
            try? myListItem.save()
        }
    }
    
}
