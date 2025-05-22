//
//  MyListView.swift
//  Reminders
//
//  Created by Victor Deon on 22/05/25.
//

import SwiftUI

struct MyListsView: View {

    // não faz chamados ao MyListsViewModel initializer igual ao ObservedObject
    @StateObject var controller: MyListsController
    
    init(controller: MyListsController) {
        _controller = StateObject(wrappedValue: controller)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            List {
                AllCountView(count: controller.allListItemCount)
                Text("My Lists").padding(.bottom, 7)
                ForEach(controller.myLists) { myList in
                    NavigationLink {
                        MyListItemsHeaderView(name: myList.name, count: myList.itemsCount, color: myList.color)
                        MyListItemsView(
                            items: myList.items,
                            onItemAdded: { title, dueDate in
                                controller.saveTo(list: myList, title: title, dueDate: dueDate)
                            },
                            onItemDeleted: controller.deleteItem,
                            onItemCompleted: controller.markAsCompleted
                        )
                    } label: {
                        HStack {
                            Image(systemName: Constants.Icons.line3HorizontalCircleFill)
                                .font(.title)
                                .foregroundStyle(myList.color)

                            Text(myList.name)
                            Spacer()
                            Text("\(myList.itemsCount)")
                        }
                    }.contextMenu {
                        Button {
                            controller.delete(myList)
                        } label: {
                            Label("Delete", systemImage: Constants.Icons.trash)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let viewContext = CoreDataManager.shared.persistentContainer.viewContext
    MyListsView(controller: MyListsController(context: viewContext))
}
