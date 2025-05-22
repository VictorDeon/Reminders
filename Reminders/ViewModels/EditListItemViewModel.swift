import Foundation

class EditListItemViewModel: ObservableObject {
    var listItemViewModel: MyListItemViewModel
    
    @Published var title: String = ""
    @Published var selectedDate: Date?
    
    init(listItemViewModel: MyListItemViewModel) {
        self.listItemViewModel = listItemViewModel
        title = listItemViewModel.title
        selectedDate = listItemViewModel.dueDate?.value ?? nil
    }
    
    func save() {
        let myListItem: MyListItem? = MyListItem.byId(id: listItemViewModel.listItemId)
        if let myListItem = myListItem {
            myListItem.title = title
            myListItem.dueDate = selectedDate
            try? myListItem.save()
        }
    }
    
}
