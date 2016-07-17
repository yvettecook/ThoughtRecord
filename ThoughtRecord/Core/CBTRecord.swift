//import Realm
//import RealmSwift
//
//protocol Record {
//
//    var date: NSDate { get }
//    var steps: [CBTStep]? { get }
//
//}
//
//extension Record {
//    var date: NSDate {
//        get {
//            return NSDate()
//        }
//    }
//}
//
//
//class CBTRecord: Record {
//
//    var steps: [CBTStep]?
//
//    required init() {
//        let step1 = Step(id: "1", title: "Situation / Trigger", prompt: "Body sensations", responses: [Text()])
//        let step2 = Step(id: "2", title: "Feelings / Emotions", prompt: "What emotion did I feel at that time? What else? How intense was it? What did I notice in my body? Where did I feel it?", responses: [Scale(), Text()])
//        let step3 = Step(id: "3", title: "Unhelpful Thoughts / Images", prompt: "What went through my mind? What disturbed me? What did those thoughts/images/memories mean to me, or say about me or the situation? What am I responding to? What ‘button’ is this pressing for me? What would be the worst thing about that, or that could happen?", responses: [Text()])
//        let step4 = Step(id: "4", title: "Facts that support the unhelpful thought", prompt: "What are the facts? What facts do I have that the unhelpful thought/s are totally true?", responses: [Text()])
//        let step5 = Step(id: "5", title: "Facts that provide evidence against the unhelpful thought", prompt: "What facts do I have that the unhelpful thought/s are NOT totally true? Is it possible that this is opinion, rather than fact? What have others said about this?", responses: [Text()])
//
//        let step6 = Step(id: "6", title: "Alternative, more realistic and balanced perspective", prompt: "STOP! Take a breath.... What would someone else say about this situation? What’s the bigger picture? Is there another way of seeing it? What advice would I give someone else? Is my reaction in proportion to the actual event? Is this really as important as it seems?", responses: [Text()])
//        let step7 = Step(id: "7", title: "Outcome / Re-rate emotion", prompt: "What am I feeling now? What could I do differently? What would be more effective? Do what works! Act wisely. What will be most helpful for me or the situation? What will the consequences be?", responses: [Scale(), Text()])
//
//        self.steps = [step1, step2, step3, step4, step5, step6, step7]
//    }
//
//}
//
//class Step {
//
//    let id: String
//    let title: String
//    let prompt: String
//    let responses: [Response]
//
//    required init(id: String, title: String, prompt: String, responses: [Response]) {
//        self.id = id
//        self.title = title
//        self.prompt = prompt
//        self.responses = responses
//    }
//
//}
//
//enum ResponseType {
//    case Text
//    case Scale
//}
//
//protocol Response {
//    var type: ResponseType { get }
//}
//
//class Text: Response {
//    let type = ResponseType.Text
//    var response: String?
//}
//
//class Scale: Response {
//    let type = ResponseType.Scale
//    var response: Int?
//}
//
//
//
//
//
