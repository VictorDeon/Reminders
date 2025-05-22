import Foundation
import SwiftUI
import CoreData

class MyListsController: NSObject, ObservableObject {
    @Published var myLists = [MyListInstanceController]()
    /// Essa controller simplifica o uso do NSFetchRequest em UIs que precisam reagir a mudanças (crud)
    private let fetchedResultsController: NSFetchedResultsController<MyList>
    /// É o ambiente em que seus objetos Core Data vivem, todo CRUD ocorre dentro desse contexto.
    private let context: NSManagedObjectContext
    
    var allListItemCount: Int {
        myLists.reduce(0) { previous, viewModel in
            previous + viewModel.itemsCount
        }
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: MyList.all,       // O request configurado em MyList.all
            managedObjectContext: context,  // O contexto onde a busca será executada
            sectionNameKeyPath: nil,        // Dividir em seções
            cacheName: nil                  // Cachear resultados
        )
        super.init()
        /// Permite que o NSFetchedResultsControllerDelegate funcione para essa view model
        fetchedResultsController.delegate = self
        setupObservers()
        fetchAll()
    }
 
    /// Preenche o myList logo ao iniciar.
    private func fetchAll() {
        do {
            /// Carrega do disco para a memória todas as MyList existentes
            try fetchedResultsController.performFetch()
            guard let myLists = fetchedResultsController.fetchedObjects else { return }
            /// Transforma cada myList em um MyListViewModel que expoem o id, name e color
            self.myLists = myLists.map(MyListInstanceController.init)
        } catch {
            print(error)
        }
    }
    
    /// Quando atualiza o items de uma lista ele tem um delay meio chato, esse observer é para melhorar isso e atualizar a lista em tempo real
    private func setupObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(managedObjectContextObjectsDidChange),
            name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
            object: context
        )
    }
    
    @objc func managedObjectContextObjectsDidChange(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        if let updates = userInfo[NSUpdatedObjectsKey] as? Set<MyListItem>, updates.count > 0 {
            fetchAll()
        }
    }
    
    func saveTo(list: MyListInstanceController, title: String, dueDate: Date?) {
        let myListItem = MyListItem(context: context)
        myListItem.title = title
        myListItem.dueDate = dueDate
        myListItem.myList = MyList.byId(id: list.id)
        do {
            try myListItem.save()
        } catch {
            print("Ocorreu um error ao salvar o item da lista: \(error)")
        }
    }
    
    func deleteItem(_ item: MyListItemController) {
        let myListItem: MyListItem? = MyListItem.byId(id: item.listItemId)
        if let myListItem = myListItem {
            try? myListItem.delete()
        }
    }
    
    func markAsCompleted(_ item: MyListItemController) {
        let myListItem: MyListItem? = MyListItem.byId(id: item.listItemId)
        if let myListItem = myListItem {
            myListItem.isCompleted = true
            try? myListItem.save()
        }
    }
    
    /// Realiza a deleção do item myList a partir do seu id
    func delete(_ myList: MyListInstanceController) {
        let myList: MyList? = MyList.byId(id: myList.id)
        if let myList = myList {
            try? myList.delete()
        }
    }
}

extension MyListsController: NSFetchedResultsControllerDelegate {
    /// Sempre que algo mudar no contexto, esse metodo será chamado e será atualizado a propriedade observavel com o @Published (myLists)
    /// com isso o swift redescobre a mudança e atualiza a UI automaticamente.
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        /// Carrega do disco para a memória todas as MyList existentes
        guard let myLists = controller.fetchedObjects as? [MyList] else { return }
        self.myLists = myLists.map(MyListInstanceController.init)
    }
}

/// Objeto referente a cada item da lista
struct MyListInstanceController: Identifiable {
    private let myList: MyList
    
    init(myList: MyList) {
        self.myList = myList
    }
    
    var id: NSManagedObjectID {
        myList.objectID
    }
    
    var name: String {
        myList.name ?? ""
    }
    
    var color: Color {
        Color(myList.color ?? .clear)
    }
    
    var items: [MyListItemController] {
        guard let items = myList.items, let myItems = (items.allObjects as? [MyListItem]) else {
            return []
        }
        
        return myItems.filter { $0.isCompleted == false }.map(MyListItemController.init)
    }
    
    var itemsCount: Int {
        items.count
    }
}
