import Realm
import RealmSwift

class RealmFormDatabase: RecordDatabase {

    func save(record: Record) {

    }

    func readAllRecords() -> [Record] {
        return []
    }

    func convert(record record: Record) -> RealmRecord {

    }

}

class RealmRecord: Object {

    let responses = List<RealmRecordResponse>()
    let date: NSDate = NSDate()
    let formID: String = "unknown"

}

class RealmRecordResponse: Object {

    let type: String = ""
    let value: String = ""

}
