import UIKit
import RealmSwift
import ResearchKit

protocol RecordSelectionDelegate: class {
    func recordSelected(newRecord: Record)
}

class RecordTableViewController: UITableViewController, UISplitViewControllerDelegate {

    private var collapseDetailViewController = true

    var allCBTRecords: [Record]?

    weak var delegate: RecordSelectionDelegate?

    override func viewDidLoad() {
        let db = RealmRecordDatabase()
        allCBTRecords = db.readAllRecords()

        splitViewController?.delegate = self
    }

    // MARK: - UISplitViewControllerDelegate

    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        return collapseDetailViewController
    }

}

extension RecordTableViewController {

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedRecord = allCBTRecords![indexPath.row]
        self.delegate?.recordSelected(selectedRecord)

        if let reviewRecordVC = self.delegate as? ReviewRecordViewController {
            splitViewController?.showDetailViewController(reviewRecordVC, sender: nil)
        }
    }

}

extension RecordTableViewController {

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard
            let recordCount = allCBTRecords?.count
            else { return 0 }
        return recordCount
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "formCell")
        cell.textLabel?.text = "\(allCBTRecords![indexPath.row].date)"
        return cell
    }

}

extension RecordTableViewController: ORKTaskViewControllerDelegate {

    @IBAction func addButtonTapped(sender: AnyObject) {
        newForm()
    }

    func newForm() {
        let record = Form.newCBTForm()

        let orderedTask = recordToORKOrderedTask(record)

        let taskViewController = ORKTaskViewController(task: orderedTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }

    func taskViewController(taskViewController: ORKTaskViewController,
                            didFinishWithReason reason: ORKTaskViewControllerFinishReason,
                                                error: NSError?) {

        if reason == .Completed {
            let taskResult = taskViewController.result

            let record = try! Record(orkTaskResult: taskResult)
            let db = RealmRecordDatabase()
            db.save(record)
            allCBTRecords = db.readAllRecords()
            tableView.reloadData()
        }

        dismissViewControllerAnimated(true, completion: nil)
    }

}