import Foundation
import CoreData
import AppKit

@objc(MyList)
class MyList: NSManagedObject, BaseModel {
    static var all: NSFetchRequest<MyList> {
        /// Define o que você quer buscar no armazenamento, no caso todos os items do MyList
        let request: NSFetchRequest<MyList> = MyList.fetchRequest()
        request.sortDescriptors = []
        return request
    }
}

extension MyList {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyList> {
        return NSFetchRequest<MyList>(entityName: "MyList")
    }

    @NSManaged public var color: NSColor?
    @NSManaged public var name: String?
}

extension MyList : Identifiable { }

