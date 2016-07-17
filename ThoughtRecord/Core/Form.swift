import Foundation

struct Form {
    let name: String
    let steps: [Step]
}

struct Step {
    let title: String
    let prompt: String
    let items: [Item]
}

typealias ItemIdentifier = String

struct Item {
    let type: ItemType
    let identifier: ItemIdentifier
}

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




