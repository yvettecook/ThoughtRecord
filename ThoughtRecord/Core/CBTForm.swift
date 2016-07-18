import Foundation

extension Form {

    static var cbtFormIdentifers = ["Step1": ["Step1Text"],
                                    "Step2": ["Step2Scale", "Step2Text"],
                                    "Step3": ["Step3Text"],
                                    "Step4": ["Step4Text"],
                                    "Step5": ["Step5Text"],
                                    "Step6": ["Step6Text"],
                                    "Step7": ["Step7Scale", "Step7Text"]]


    static func newCBTForm() -> Form {

        let step1 = Step(identifier: "Step1",
                         title: "Situation / Trigger",
                         prompt: "Body sensations",
                         items: [Item(type: .Text, identifier: "Step1Text")])

        let step2 = Step(identifier: "Step2",
                         title: "Feelings / Emotions",
                         prompt: "What emotion did I feel at that time? What else? How intense was it? What did I notice in my body? Where did I feel it?",
                         items: [Item(type: .Scale, identifier: "Step2Scale" ), Item(type: .Text, identifier: "Step2Text")])

        let step3 = Step(identifier: "Step3",
                         title: "Unhelpful Thoughts / Images", prompt: "What went through my mind? What disturbed me? What did those thoughts/images/memories mean to me, or say about me or the situation? What am I responding to? What ‘button’ is this pressing for me? What would be the worst thing about that, or that could happen?",
                         items: [Item(type: .Text, identifier: "Step3Text")])

        let step4 = Step(identifier: "Step4",
                         title: "Facts that support the unhelpful thought", prompt: "What are the facts? What facts do I have that the unhelpful thought/s are totally true?",
                         items: [Item(type: .Text, identifier: "Step4Text")])

        let step5 = Step(identifier: "Step5",
                         title: "Facts that provide evidence against the unhelpful thought",
                         prompt: "What facts do I have that the unhelpful thought/s are NOT totally true? Is it possible that this is opinion, rather than fact? What have others said about this?", items: [Item(type: .Text,
                            identifier: "Step5Text")])

        let step6 = Step(identifier: "Step6",
                         title: "Alternative, more realistic and balanced perspective", prompt: "STOP! Take a breath.... What would someone else say about this situation? What’s the bigger picture? Is there another way of seeing it? What advice would I give someone else? Is my reaction in proportion to the actual event? Is this really as important as it seems?",
                         items: [Item(type: .Text, identifier: "Step6Text")])

        let step7 = Step(identifier: "Step7",
                         title: "Outcome / Re-rate emotion",
                         prompt: "What am I feeling now? What could I do differently? What would be more effective? Do what works! Act wisely. What will be most helpful for me or the situation? What will the consequences be?",
                         items: [Item(type: .Scale, identifier: "Step7Scale" ), Item(type: .Text, identifier: "Step7Text")])

        return Form(name: "CBTForm", steps: [step1, step2, step3, step4, step5, step6, step7])
    }
    
}
