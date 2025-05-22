import Foundation
import SwiftUI
import CoreData

class AddNewListViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var color: Color = .blue
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func save() {
        do {
            let myList = MyList(context: context)
            myList.name = name
            myList.color = NSColor(color)
            try myList.save()
        } catch {
            print("Ocorreu um error ao salvar o item na lista: \(error)")
        }
    }
}
