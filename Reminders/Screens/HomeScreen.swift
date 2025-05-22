import SwiftUI

struct HomeScreen: View {
    var body: some View {
        NavigationView {
            SideBarView()
            Text("MyListItems")
        }
        
    }
}


struct HomeScreenPreview: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
