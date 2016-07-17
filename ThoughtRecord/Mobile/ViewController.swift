import UIKit
import ResearchKit
import RealmSwift

class ViewController: UIViewController, ORKTaskViewControllerDelegate {

    let record = CBTRecord()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let orderedTask = recordToORKOrderedTask(record)

        let taskViewController = ORKTaskViewController(task: orderedTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }

    func taskViewController(taskViewController: ORKTaskViewController,
                            didFinishWithReason reason: ORKTaskViewControllerFinishReason,
                                                error: NSError?) {
        let taskResult = taskViewController.result
        // You could do something with the result here.


        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
