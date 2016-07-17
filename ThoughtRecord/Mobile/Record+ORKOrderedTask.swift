import Realm
import RealmSwift
import ResearchKit


func recordToORKOrderedTask(record: Record) -> ORKOrderedTask {

    var steps = [ORKStep]()

    let introStep = ORKInstructionStep(identifier: "intro")
    introStep.title = "Thought Record"

    steps.append(introStep)

    for step in record.steps! {
        steps.append(stepToORKFormStep(step))
    }

    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Record Completed"

    steps.append(summaryStep)

    return ORKOrderedTask(identifier: "ThoughtRecord", steps: steps)
}

func stepToORKFormStep(step: Step) -> ORKFormStep {
    let question = ORKFormStep(identifier: step.id, title: step.title, text: step.prompt)

    var items = [ORKFormItem]()
    for response in step.responses {
        items.append(responseToORKFormItem(response))
    }

    question.formItems = items

    return question

}

func responseToORKFormItem(response: Response) -> ORKFormItem {
    let item: ORKFormItem
    switch response.type {
    case .Scale:
        item = ORKFormItem(identifier: "[id]scale", text: "", answerFormat: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: 0, step: 1))
    case .Text:
        item = ORKFormItem(identifier: "[id]text", text: "", answerFormat: ORKTextAnswerFormat())
    }
    return item
}

