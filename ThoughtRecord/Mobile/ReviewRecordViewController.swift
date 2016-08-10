import UIKit

class ReviewRecordViewController: UIViewController, RecordSelectionDelegate {

    @IBOutlet weak var tableView: UITableView!

    var record: Record?

    func recordSelected(newRecord: Record) {
        self.record = newRecord
        tableView.reloadData()
        print(record?.responses)
    }

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60

        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 80

        tableView.register(ResponseCell.self)

        tableView.registerClass(ResponseHeader.self, forHeaderFooterViewReuseIdentifier: ResponseHeader.identifier)

        self.edgesForExtendedLayout = UIRectEdge.None
    }

}

extension ReviewRecordViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let recordForm = record?.form else { return 0 }
        return recordForm.steps.count
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let recordForm = record?.form
            else { preconditionFailure() }

        let title = recordForm.steps[section].title.uppercaseString

        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(ResponseHeader.identifier) as! ResponseHeader

        headerView.title.text = title

        return headerView
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recordForm = record?.form else { return 0 }
        return recordForm.steps[section].items.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ResponseCell", forIndexPath: indexPath) as! ResponseCell
        guard let record = record else { return cell }

        let stepID = record.form.steps[indexPath.section].items[indexPath.row].identifier

        let responseValue = record.responses
            .filter { $0.identifier == stepID }
            .map { $0.value }
            .flatMap { $0 }
            .map { String($0) }
            .first

        cell.response.text = responseValue
        return cell
    }

}

extension ReviewRecordViewController: UITableViewDelegate { }
