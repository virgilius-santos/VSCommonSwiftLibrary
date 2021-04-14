//
// SleepCalculator.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class SleepCalculatorInput : MLFeatureProvider {

    /// wake as double value
    var wake: Double

    /// estimatedSleep as double value
    var estimatedSleep: Double

    /// coffee as double value
    var coffee: Double

    var featureNames: Set<String> {
        get {
            return ["wake", "estimatedSleep", "coffee"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "wake") {
            return MLFeatureValue(double: wake)
        }
        if (featureName == "estimatedSleep") {
            return MLFeatureValue(double: estimatedSleep)
        }
        if (featureName == "coffee") {
            return MLFeatureValue(double: coffee)
        }
        return nil
    }
    
    init(wake: Double, estimatedSleep: Double, coffee: Double) {
        self.wake = wake
        self.estimatedSleep = estimatedSleep
        self.coffee = coffee
    }
}


/// Model Prediction Output Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class SleepCalculatorOutput : MLFeatureProvider {

    /// Source provided by CoreML

    private let provider : MLFeatureProvider


    /// actualSleep as double value
    lazy var actualSleep: Double = {
        [unowned self] in return self.provider.featureValue(for: "actualSleep")!.doubleValue
    }()

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(actualSleep: Double) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["actualSleep" : MLFeatureValue(double: actualSleep)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class SleepCalculator {
    let model: MLModel

    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        Bundle.module.url(forResource: "SleepCalculator", withExtension:"mlmodelc")!
    }

    /**
        Construct SleepCalculator instance with an existing MLModel object.

        Usually the application does not use this initializer unless it makes a subclass of SleepCalculator.
        Such application may want to use `MLModel(contentsOfURL:configuration:)` and `SleepCalculator.urlOfModelInThisBundle` to create a MLModel object to pass-in.

        - parameters:
          - model: MLModel object
    */
    init(model: MLModel) {
        self.model = model
    }

    /**
        Construct SleepCalculator instance by automatically loading the model from the app's bundle.
    */
    @available(*, deprecated, message: "Use init(configuration:) instead and handle errors appropriately.")
    convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
        Construct a model with configuration

        - parameters:
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct SleepCalculator instance with explicit path to mlmodelc file
        - parameters:
           - modelURL: the file url of the model

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL) throws {
        try self.init(model: MLModel(contentsOf: modelURL))
    }

    /**
        Construct a model with URL of the .mlmodelc directory and configuration

        - parameters:
           - modelURL: the file url of the model
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(contentsOf modelURL: URL, configuration: MLModelConfiguration) throws {
        try self.init(model: MLModel(contentsOf: modelURL, configuration: configuration))
    }

    /**
        Construct SleepCalculator instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<SleepCalculator, Error>) -> Void) {
        return self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
    }

    /**
        Construct SleepCalculator instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<SleepCalculator, Error>) -> Void) {
        MLModel.__loadContents(of: modelURL, configuration: configuration) { (model, error) in
            if let error = error {
                handler(.failure(error))
            } else if let model = model {
                handler(.success(SleepCalculator(model: model)))
            } else {
                fatalError("SPI failure: -[MLModel loadContentsOfURL:configuration::completionHandler:] vends nil for both model and error.")
            }
        }
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as SleepCalculatorInput

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as SleepCalculatorOutput
    */
    func prediction(input: SleepCalculatorInput) throws -> SleepCalculatorOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as SleepCalculatorInput
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as SleepCalculatorOutput
    */
    func prediction(input: SleepCalculatorInput, options: MLPredictionOptions) throws -> SleepCalculatorOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return SleepCalculatorOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface

        - parameters:
            - wake as double value
            - estimatedSleep as double value
            - coffee as double value

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as SleepCalculatorOutput
    */
    func prediction(wake: Double, estimatedSleep: Double, coffee: Double) throws -> SleepCalculatorOutput {
        let input_ = SleepCalculatorInput(wake: wake, estimatedSleep: estimatedSleep, coffee: coffee)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface

        - parameters:
           - inputs: the inputs to the prediction as [SleepCalculatorInput]
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as [SleepCalculatorOutput]
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    func predictions(inputs: [SleepCalculatorInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [SleepCalculatorOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [SleepCalculatorOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  SleepCalculatorOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
