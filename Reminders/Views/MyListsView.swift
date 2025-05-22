//
//  MyListView.swift
//  Reminders
//
//  Created by Victor Deon on 22/05/25.
//

import SwiftUI

struct MyListsView: View {

    // não faz chamados ao MyListsViewModel initializer igual ao ObservedObject
    @StateObject var viewModel: MyListsViewModel
    
    init(viewModel: MyListsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            List {
                AllCountView(count: viewModel.allListItemCount)
                Text("My Lists").padding(.bottom, 7)
                ForEach(viewModel.myLists) { myList in
                    NavigationLink {
                        MyListItemsHeaderView(name: myList.name, count: myList.itemsCount, color: myList.color)
                        MyListItemsView(
                            items: myList.items,
                            onItemAdded: { title, dueDate in
                                viewModel.saveTo(list: myList, title: title, dueDate: dueDate)
                            },
                            onItemDeleted: viewModel.deleteItem,
                            onItemCompleted: viewModel.markAsCompleted
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
                            viewModel.delete(myList)
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
    MyListsView(viewModel: MyListsViewModel(context: viewContext))
}
