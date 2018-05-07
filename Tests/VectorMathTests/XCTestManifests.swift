import XCTest

extension Matrix3Tests {
    static let __allTests = [
        ("testMatrix3Multiplication", testMatrix3Multiplication),
        ("testRotation", testRotation),
        ("testScale", testScale),
        ("testTranslation", testTranslation),
        ("testVector2Multiplication", testVector2Multiplication),
        ("testVector3Multiplication", testVector3Multiplication),
    ]
}

extension Matrix4Tests {
    static let __allTests = [
        ("testRotation", testRotation),
        ("testRotationAndTranslation", testRotationAndTranslation),
        ("testScale", testScale),
        ("testTransformationMatrixMultiplication", testTransformationMatrixMultiplication),
        ("testTranslation", testTranslation),
    ]
}

extension PerformanceTests {
    static let __allTests = [
        ("testMatrix3MultiplicationPerformance", testMatrix3MultiplicationPerformance),
        ("testMatrix4MultiplicationPerformance", testMatrix4MultiplicationPerformance),
    ]
}

extension QuaternionTests {
    static let __allTests = [
        ("testAxisAngleConversion", testAxisAngleConversion),
        ("testEulerConversion", testEulerConversion),
        ("testMatrix4Conversion", testMatrix4Conversion),
        ("testVector3Multiplication", testVector3Multiplication),
    ]
}

extension Vector2Tests {
    static let __allTests = [
        ("testAngleWith", testAngleWith),
        ("testRotatedBy", testRotatedBy),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Matrix3Tests.__allTests),
        testCase(Matrix4Tests.__allTests),
        testCase(PerformanceTests.__allTests),
        testCase(QuaternionTests.__allTests),
        testCase(Vector2Tests.__allTests),
    ]
}
#endif
