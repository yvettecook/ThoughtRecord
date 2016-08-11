import Realm
import RealmSwift

class RealmRecordDatabase: RecordDatabase {

    func save(record: Record) {
        let convertedRecord = convert(record)
        let realm = try! Realm()

        try! realm.write {
            realm.add(convertedRecord)
        }
    }

    func readAllRecords() -> [Record] {
        let realm = try! Realm()

        let realmRecords = realm.objects(RealmRecord.self)
        let records = realmRecords.flatMap { convert($0) }

        return records
    }

    func delete(record: Record) {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "date = %@", record.date)
        let recordToDelete = realm.objects(RealmRecord.self).filter(predicate)

        try! realm.write {
            realm.delete(recordToDelete)
        }
    }

    private func convert(record: Record) -> RealmRecord {
        return RealmRecord(record: record)
    }

    private func convert(realmRecord: RealmRecord) -> Record? {
        return Record(realmRecord: realmRecord)
    }

}

struct RealmConvertibleError: ErrorType {
    let message: String?
}


class RealmRecord: Object {

    let responses = List<RealmRecordResponse>()
    dynamic var date: NSDate = NSDate.distantFuture()
    dynamic var formID: String = "unknown"

    convenience init(record: Record) {
        self.init()

        self.date = record.date
        self.formID = record.form.name

        let realmResponses = record.responses.map { RealmRecordResponse(response: $0) }

        for i in realmResponses {
            self.responses.append(i)
        }
    }

}

extension Record {

    init(realmRecord: RealmRecord) {
        self.date = realmRecord.date
        self.form = Form.newCBTForm()
        self.responses = realmRecord.responses.map { try! RecordResponse(realmRecordResponse: $0) }
    }

}

class RealmRecordResponse: Object {

    dynamic var identifier: String = ""
    dynamic var type: String = ""
    dynamic var value: String = ""

    convenience init(response: RecordResponse) {
        self.init()

        self.identifier = response.identifier
        self.type = response.type.rawValue
        
        if let value = response.value {
            self.value = "\(value)"
        } else {
            self.value = ""
        }
    }

}

extension RecordResponse {

    init(realmRecordResponse: RealmRecordResponse) throws {
        self.identifier = realmRecordResponse.identifier

        switch realmRecordResponse.type {
        case "Scale":
            self.type = .Scale
            self.value = Int(realmRecordResponse.value)
        case "Text":
            self.type = .Text
            self.value = realmRecordResponse.value
        default:
            throw RealmConvertibleError(message: "Problem converting: \(realmRecordResponse)")
        }
    }

}
