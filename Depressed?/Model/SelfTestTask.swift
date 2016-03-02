import ResearchKit

/// Task that contains the questions of the [PHQ-9](https://en.wikipedia.org/wiki/Patient_Health_Questionnaire#Versions) questionnaire.
public class SelfTestTask: NSObject, ORKTask {

    private let steps: [ORKStep]
    
    /// The identifier of the task.
    public let identifier = "SelfTest"    

    ///  Creates a new self test task
    ///
    ///  - returns: a newly initialized `SelfTestTask` instance
    public override init() {
        let pleasureInterestQuestion = Question(identifier: .LosingInterest)
        let depressedQuestion = Question(identifier: .FeelingDepressed)
        let sleepQuestion = Question(identifier: .TroubleSleeping)
        let tiredQuestion = Question(identifier: .FeelingTired)
        let appetiteQuestion = Question(identifier: .PoorAppetite)
        let selfEsteemQuestion = Question(identifier: .LowSelfEsteem)
        let concentrationQuestion = Question(identifier: .TroubleConcentrating)
        let slowFastQuestion = Question(identifier: .SlowOrFast)
        let suicideQuestion = Question(identifier: .FeelingSuicidal)
        
        steps = [
            pleasureInterestQuestion.step,
            depressedQuestion.step,
            sleepQuestion.step,
            tiredQuestion.step,
            appetiteQuestion.step,
            selfEsteemQuestion.step,
            concentrationQuestion.step,
            slowFastQuestion.step,
            suicideQuestion.step
        ]
    }

    ///  Returns the step before the given step.
    ///
    ///  - parameter step:   The current step.
    ///  - parameter result: The current task result.
    ///
    ///  - returns: The step before the given step.
    public func stepBeforeStep(step: ORKStep?, withResult result: ORKTaskResult) -> ORKStep? {
        if let step = step {
            // return appropiate step
            let index = steps.indexOf(step)
            if let index = index where index - 1 >= 0 {
                return steps[index - 1]
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

    ///  Returns the step after the given step.
    ///
    ///  - parameter step:   The current step.
    ///  - parameter result: The current task result.
    ///
    ///  - returns: The step after the given step.
    public func stepAfterStep(step: ORKStep?, withResult result: ORKTaskResult) -> ORKStep? {

        if let step = step {
            // return appropiate step
            let index = steps.indexOf(step)
            if let index = index where index + 1 < steps.count {
                return steps[index + 1]
            } else {
                return nil
            }
        } else {
            // return first step
            return steps.first!
        }

    }
    
    ///  Returns the progress of the current step.
    ///
    ///  - parameter step:   The current step.
    ///  - parameter result: The current task result.
    ///
    ///  - returns: The progress of the current step.
    public func progressOfCurrentStep(step: ORKStep, withResult result: ORKTaskResult) -> ORKTaskProgress {
        let index = steps.indexOf(step)

        if let index = index {
            return ORKTaskProgressMake(UInt(index), UInt(steps.count))
        }
        
        return ORKTaskProgressMake(0, UInt(steps.count))
    }

}
