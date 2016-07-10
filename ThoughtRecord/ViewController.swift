import UIKit
import ResearchKit
import RealmSwift

class ViewController: UIViewController, ORKTaskViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let step1 = ORKInstructionStep(identifier: "intro")
        step1.title = "Thought Record"

        let format = ORKTextAnswerFormat()

        let question1 = ORKQuestionStep(identifier: "question1", title: "Situation / Trigger", answer: format)
        question1.text = "Body sensations"

        let question2 = ORKFormStep(identifier: "question2", title: "Feelings / Emotions", text: "What emotion did I feel at that time? What else? How intense was it? What did I notice in my body? Where did I feel it?")
        let scale = ORKFormItem(identifier: "question2Scale", text: "", answerFormat: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: 0, step: 1))
        let text = ORKFormItem(identifier: "question2Text", text: "", answerFormat: ORKTextAnswerFormat())
        question2.formItems = [scale, text]


        let question3 = ORKQuestionStep(identifier: "question3", title: "Unhelpful Thoughts / Images", answer: format)
        question3.text = "What went through my mind? What disturbed me? What did those thoughts/images/memories mean to me, or say about me or the situation? What am I responding to? What ‘button’ is this pressing for me? What would be the worst thing about that, or that could happen?"

        let question4 = ORKQuestionStep(identifier: "question4", title: "Facts that support the unhelpful thought", answer: format)
        question4.text = "What are the facts? What facts do I have that the unhelpful thought/s are totally true?"

        let question5 = ORKQuestionStep(identifier: "question5", title: "Facts that provide evidence against the unhelpful thought", answer: format)
        question5.text = "What facts do I have that the unhelpful thought/s are NOT totally true? Is it possible that this is opinion, rather than fact? What have others said about this?"

        let question6 = ORKQuestionStep(identifier: "question6", title: "Alternative, more realistic and balanced perspective", answer: format)
        question6.text = "STOP! Take a breath.... What would someone else say about this situation? What’s the bigger picture? Is there another way of seeing it? What advice would I give someone else? Is my reaction in proportion to the actual event? Is this really as important as it seems?"


        let question7 = ORKFormStep(identifier: "question7", title: "Outcome / Re-rate emotion", text: "What am I feeling now? What could I do differently? What would be more effective? Do what works! Act wisely. What will be most helpful for me or the situation? What will the consequences be?")
        question7.formItems = [scale, text]

        let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
        summaryStep.title = "Record Completed"

        let task1 = ORKOrderedTask(identifier: "task", steps: [step1, question1 /*, question2, question3, question4, question5, question6, question7, summaryStep*/])

        let taskViewController = ORKTaskViewController(task: task1, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }

    func taskViewController(taskViewController: ORKTaskViewController,
                            didFinishWithReason reason: ORKTaskViewControllerFinishReason,
                                                error: NSError?) {
        let taskResult = taskViewController.result
        // You could do something with the result here.
        print("task result: \(taskResult)")

        let record = Record()
        let q1ORKResult = taskResult.resultForIdentifier("question1") as! ORKStepResult
        let q1SubAnswer = q1ORKResult.results![0] as! ORKTextQuestionResult
        record.question1 = q1SubAnswer.answer as! String

        let realm = try! Realm()

        try! realm.write {
            realm.add(record)
        }

        dismissViewControllerAnimated(true, completion: nil)
    }

}

