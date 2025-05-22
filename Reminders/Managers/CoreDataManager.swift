import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    private init() {
        ValueTransformer.setValueTransformer(
            NSColorTransformer(),
            forName: NSValueTransformerName("NSColorTransformer")
        )
        
        persistentContainer = NSPersistentContainer(name: "RemindersModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error as NSError? {
                fatalError("Enable to initialize Core Data: \(error), \(error.userInfo)")
            }
        }
    }
}
