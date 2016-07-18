import Foundation

struct Record {
    let responses: [RecordResponse]
    let date: NSDate
    let form: Form
}

struct RecordResponse {
    let identifier: ItemIdentifier
    let type: ItemType
    let value: AnyObject?
}

enum ItemType: String {
    case Scale = "Scale"
    case Text = "Text"
}
