import Realm
import RealmSwift
import ResearchKit


func recordToORKOrderedTask(form: Form) -> ORKOrderedTask {

    var steps = [ORKStep]()

    let introStep = ORKInstructionStep(identifier: "intro")
    introStep.title = "Thought Record"

    steps.append(introStep)

    for step in form.steps {
        steps.append(stepToORKFormStep(step))
    }

    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Record Completed"

    steps.append(summaryStep)

    return ORKOrderedTask(identifier: "ThoughtRecord", steps: steps)
}

func stepToORKFormStep(step: Step) -> ORKFormStep {
    let question = ORKFormStep(identifier: step.identifier, title: step.title, text: step.prompt)

    var items = [ORKFormItem]()
    for item in step.items {
        items.append(itemToORKFormItem(item))
    }

    question.formItems = items

    return question

}

func itemToORKFormItem(item: Item) -> ORKFormItem {
    let formItem: ORKFormItem
    switch item.type {
    case .Scale:
        formItem = ORKFormItem(identifier: item.identifier, text: "", answerFormat: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: 0, step: 1))
    case .Text:
        formItem = ORKFormItem(identifier: item.identifier, text: "", answerFormat: ORKTextAnswerFormat())
    }
    return formItem
}

