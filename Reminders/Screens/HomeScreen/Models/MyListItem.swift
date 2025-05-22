import Foundation
import CoreData

@objc(MyListItem)
class MyListItem: NSManagedObject, BaseModel { }

extension MyListItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyListItem> {
        return NSFetchRequest<MyListItem>(entityName: "MyListItem")
    }
    
    @NSManaged public var dueDate: Date?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String
    @NSManaged public var myList: MyList?
}

extension MyListItem : Identifiable { }
