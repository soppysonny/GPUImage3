public class HighlightBoost: BasicOperation {
    public var amount: Float = 0.0 { didSet { uniformSettings["amount"] = amount } }
    public var threshold: Float = 0.65 { didSet { uniformSettings["threshold"] = threshold } }
    public var softness: Float = 0.25 { didSet { uniformSettings["softness"] = softness } }

    public init() {
        super.init(fragmentFunctionName: "highlightBoostFragment", numberOfInputs: 1)

        ({ amount = 0.0 })()
        ({ threshold = 0.65 })()
        ({ softness = 0.25 })()
    }
}
