import Foundation

typealias ItemIdentifier = String
typealias StepIdentifier = String

struct Form {
    let name: String
    let steps: [Step]
}

struct Step {
    let identifier: StepIdentifier
    let title: String
    let prompt: String
    let items: [Item]
}

struct Item {
    let type: ItemType
    let identifier: ItemIdentifier
}
