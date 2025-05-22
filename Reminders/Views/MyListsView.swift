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
                Text("My Lists").padding(.bottom, 7)
                ForEach(viewModel.myLists) { myList in
                    HStack {
                        Image(systemName: Constants.Icons.line3HorizontalCircleFill)
                            .font(.title)
                            .foregroundStyle(myList.color)

                        Text(myList.name)
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
