import Foundation
import AppKit

class NSColorTransformer: ValueTransformer {
    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? NSColor else { return nil }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
            return data
        } catch {
            print("Ocorreu um error ao tentar transformar o objeto NSColor em Data: \(error)")
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSColor.self, from: data)
            return color
        } catch {
            print("Ocorreu um error ao tentar transformar o objeto Data em NSColor: \(error)")
            return nil
        }
    }
}
