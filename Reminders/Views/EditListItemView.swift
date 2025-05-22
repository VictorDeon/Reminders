//
//  EditListItemView.swift
//  Reminders
//
//  Created by Victor Deon on 22/05/25.
//

import SwiftUI

struct EditListItemView: View {
    
    var item: MyListItemController
    @State private var selectedDate: Date = Date.today
    @State private var showCalendar: Bool = false
    @ObservedObject var editListItemController: EditListItemController
    var onUpdate: () -> Void
    
    init(item: MyListItemController, onUpdate: @escaping () -> Void) {
        self.item = item
        self.onUpdate = onUpdate
        editListItemController = EditListItemController(listItemController: item)
    }
    
    var calendarButtonTitle: String {
        editListItemController.selectedDate?.formatAsString ?? "Add Date"
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(item.title, text: $editListItemController.title)
                .textFieldStyle(.plain)
            
            Divider()
            
            HStack {
                Text("Due Date:")
                CalendarButtonView(title: calendarButtonTitle, showCalendar: $showCalendar) { selectedDate in
                    editListItemController.selectedDate = selectedDate
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Button("Done") {
                    editListItemController.save()
                    onUpdate()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .frame(minWidth: 200, minHeight: 200)
    }
}

#Preview {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    EditListItemView(item: MyListItemController(myListItem: MyListItem(context: context)), onUpdate: {})
}
