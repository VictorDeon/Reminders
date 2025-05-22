import Foundation
import CoreData

protocol BaseModel {
    static var viewContext: NSManagedObjectContext { get }
    func save() throws
    static func byId<T>(id: NSManagedObjectID) -> T?
    func delete() throws
}

extension BaseModel where Self: NSManagedObject {
    static var viewContext: NSManagedObjectContext {
        return CoreDataManager.shared.persistentContainer.viewContext
    }
    
    func save() throws {
        try Self.viewContext.save()
    }
    
    static func byId<T>(id: NSManagedObjectID) -> T? {
        return viewContext.object(with: id) as? T
    }
    
    func delete() throws {
        Self.viewContext.delete(self)
        try save()
    }
}
