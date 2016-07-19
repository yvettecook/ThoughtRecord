import Foundation
import ResearchKit

struct ORKConvertibleError: ErrorType {}

extension Record {
    init(orkTaskResult: ORKTaskResult) throws {
        self.date = NSDate()
        self.form = Form.newCBTForm()
        var responses = [RecordResponse]()

        for id in Form.cbtFormIdentifers {
            guard let matchingStep = orkTaskResult.resultForIdentifier(id.0) as? ORKStepResult
                else {
                    break
            }

            for stepID in id.1 {
                guard let matchingResult = matchingStep.resultForIdentifier(stepID)
                    else { throw ORKConvertibleError() }

                var type: ItemType
                var value: AnyObject?

                if let response = matchingResult as? ORKTextQuestionResult {
                    type = ItemType.Text
                    value = response.textAnswer
                } else if let response = matchingResult as? ORKScaleQuestionResult {
                    type = ItemType.Scale
                    if let scaleNum = response.scaleAnswer {
                        value = Int(scaleNum)
                    }
                } else {
                    throw ORKConvertibleError()
                }

                let response = RecordResponse(identifier: stepID, type: type, value: value)
                responses.append(response)
            }

        }

        self.responses = responses

    }
}
