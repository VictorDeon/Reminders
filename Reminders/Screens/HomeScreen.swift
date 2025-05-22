import SwiftUI

struct HomeScreen: View {
    
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    var body: some View {
        NavigationView {
            
            let myListController = MyListsController(context: context)
            let firstListInstanceController = myListController.myLists.first
            
            SideBarView()

            if let firstList = firstListInstanceController {
                MyListItemsHeaderView(
                    name: firstList.name,
                    count: firstList.itemsCount,
                    color: firstList.color
                )
                MyListItemsView(items: firstList.items)
            } else {
                Text("Create your first list")
            }
        }
        
    }
}


struct HomeScreenPreview: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
