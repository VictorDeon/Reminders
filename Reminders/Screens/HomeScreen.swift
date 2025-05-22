import SwiftUI

struct HomeScreen: View {
    
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    var body: some View {
        NavigationView {
            
            let myListViewModel = MyListsViewModel(context: context)
            let firstListViewModel = myListViewModel.myLists.first
            
            SideBarView()
            
            if let firstList = firstListViewModel {
                MyListItemsHeaderView(
                    name: firstList.name,
                    count: firstList.itemsCount,
                    color: firstList.color
                )
                MyListItemsView(items: firstList.items)
            } else {
                Text("Create your first view list")
            }
        }
        
    }
}


struct HomeScreenPreview: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
