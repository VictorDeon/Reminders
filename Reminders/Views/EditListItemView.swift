//
//  EditListItemView.swift
//  Reminders
//
//  Created by Victor Deon on 22/05/25.
//

import SwiftUI

struct EditListItemView: View {
    
    var item: MyListItemViewModel
    @State private var selectedDate: Date = Date.today
    @State private var showCalendar: Bool = false
    @ObservedObject var editListItemViewModel: EditListItemViewModel
    var onUpdate: () -> Void
    
    init(item: MyListItemViewModel, onUpdate: @escaping () -> Void) {
        self.item = item
        self.onUpdate = onUpdate
        editListItemViewModel = EditListItemViewModel(listItemViewModel: item)
    }
    
    var calendarButtonTitle: String {
        editListItemViewModel.selectedDate?.formatAsString ?? "Add Date"
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(item.title, text: $editListItemViewModel.title)
                .textFieldStyle(.plain)
            
            Divider()
            
            HStack {
                Text("Due Date:")
                CalendarButtonView(title: calendarButtonTitle, showCalendar: $showCalendar) { selectedDate in
                    editListItemViewModel.selectedDate = selectedDate
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Button("Done") {
                    editListItemViewModel.save()
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
    EditListItemView(item: MyListItemViewModel(myListItem: MyListItem(context: context)), onUpdate: {})
}
