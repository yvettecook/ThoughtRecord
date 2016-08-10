import Foundation

protocol RecordDatabase {

    func save(record: Record)
    func readAllRecords() -> [Record]

}
