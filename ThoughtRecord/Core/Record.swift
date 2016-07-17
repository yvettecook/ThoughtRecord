import Foundation

struct Record {
    let responses: [RecordResponse]
    let date: NSDate
    let form: Form
}

struct RecordResponse {
    let type: ItemType
    let value: AnyObject
}

enum ItemType {
    case Scale
    case Text
}
