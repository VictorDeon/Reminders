import SwiftUI

struct ListItemCell: View {
    
    @State private var active: Bool = false
    @State private var showPopover: Bool = false
    @State private var checked: Bool = false

    let item: MyListItemViewModel
    
    let delay = Delay()

    var onListItemDeleted: (MyListItemViewModel) -> Void = { _ in }
    var onListItemCompleted: (MyListItemViewModel) -> Void = { _ in }
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: checked ? Constants.Icons.circleInsetFilled : Constants.Icons.circle)
                .font(.system(size: 14))
                .opacity(0.2)
                .onTapGesture {
                    checked.toggle()

                    // Aperta e espera 2 segundos, se esperar sera deletado se clicar novamente e descelecionar ele cancela
                    if checked {
                        delay.performWork {
                            onListItemCompleted(item)
                        }
                    } else {
                        delay.cancel()
                    }
                }
            
            VStack(alignment: .leading) {
                Text(item.title)
                if let dueDate = item.dueDate {
                    Text(dueDate.title)
                        .opacity(0.4)
                        .foregroundStyle(dueDate.isPastDue ? .red : .primary)
                }
            }
            
            Spacer()
            
            if active {
                Image(systemName: Constants.Icons.multiplyCircle)
                    .font(.system(size: 16))
                    .foregroundStyle(.red)
                    .onTapGesture {
                        onListItemDeleted(item)
                    }
                
                Image(systemName: Constants.Icons.exclaimationMarkCircle)
                    .font(.system(size: 16))
                    .foregroundStyle(.purple)
                    .onTapGesture {
                        showPopover = true
                    }
                    .popover(isPresented: $showPopover, arrowEdge: .leading) {
                        EditListItemView(item: item) {
                            showPopover = false
                        }
                    }
            }
        }
        .contentShape(Rectangle())
        .onHover(perform: { value in
            if !showPopover {
                active = value
            }
        })
        .padding()
    }
}

//#Preview {
//    ListItemCell(item: MyListItemViewModel(myListItem: MyListItem()))
//}
