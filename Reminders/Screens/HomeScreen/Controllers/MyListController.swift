import Foundation
import SwiftUI
import CoreData

/// Objeto referente a cada item da lista
struct MyListController: Identifiable {
    private let myList: MyList
    
    init(myList: MyList) {
        self.myList = myList
    }
    
    var id: NSManagedObjectID {
        myList.objectID
    }
    
    var name: String {
        myList.name ?? ""
    }
    
    var color: Color {
        Color(myList.color ?? .clear)
    }
    
    var items: [MyListItemController] {
        guard let items = myList.items, let myItems = (items.allObjects as? [MyListItem]) else {
            return []
        }
        
        return myItems.filter { $0.isCompleted == false }.map(MyListItemController.init)
    }
    
    var itemsCount: Int {
        items.count
    }
}

