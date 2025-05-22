import Foundation
import SwiftUI
import CoreData

class MyListsViewModel: NSObject, ObservableObject {
    @Published var myLists = [MyListItemViewModel]()
    /// Essa controller simplifica o uso do NSFetchRequest em UIs que precisam reagir a mudanças (crud)
    private let fetchedResultsController: NSFetchedResultsController<MyList>
    /// É o ambiente em que seus objetos Core Data vivem, todo CRUD ocorre dentro desse contexto.
    private let context: NSManagedObjectContext
    
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
        fetchAll()
    }
 
    /// Preenche o myList logo ao iniciar.
    private func fetchAll() {
        do {
            /// Carrega do disco para a memória todas as MyList existentes
            try fetchedResultsController.performFetch()
            guard let myLists = fetchedResultsController.fetchedObjects else { return }
            /// Transforma cada myList em um MyListViewModel que expoem o id, name e color
            self.myLists = myLists.map(MyListItemViewModel.init)
        } catch {
            print(error)
        }
    }
    
    /// Realiza a deleção do item myList a partir do seu id
    func delete(_ myList: MyListItemViewModel) {
        let myList: MyList? = MyList.byId(id: myList.id)
        if let myList = myList {
            try? myList.delete()
        }
    }
}

extension MyListsViewModel: NSFetchedResultsControllerDelegate {
    /// Sempre que algo mudar no contexto, esse metodo será chamado e será atualizado a propriedade observavel com o @Published (myLists)
    /// com isso o swift redescobre a mudança e atualiza a UI automaticamente.
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        /// Carrega do disco para a memória todas as MyList existentes
        guard let myLists = controller.fetchedObjects as? [MyList] else { return }
        self.myLists = myLists.map(MyListItemViewModel.init)
    }
}

/// Objeto referente a cada item da lista
struct MyListItemViewModel: Identifiable {
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
}
