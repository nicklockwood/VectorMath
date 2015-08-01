//
//  VectorMathTests.swift
//  VectorMathTests
//
//  Created by Nick Lockwood on 24/11/2014.
//  Copyright (c) 2014 Nick Lockwood. All rights reserved.
//

import QuartzCore
import XCTest

class Vector2Tests: XCTestCase {
    
    func testRotatedBy() {
        
        let a = Vector2(1, 0)
        let b = Vector2(0, 1)
        let c = a.rotatedBy(.HalfPi)

        XCTAssertTrue(b ~= c)
        
        let d = Vector2(0.5, 1.5)
        let e = a.rotatedBy(.HalfPi, around: Vector2(0, 0.5))

        XCTAssertTrue(d ~= e)
    }
    
    func testAngleWith() {
        
        let a = Vector2(1, 0)
        let b = Vector2(0, 1)
        let angle = a.angleWith(b)
        
        XCTAssertTrue(angle ~= .HalfPi)
    }
}

class Matrix3Tests: XCTestCase {
    
    func testScale() {
        
        let transform = CGAffineTransformMakeScale(0.3, 0.4)
        let matrix = Matrix3(transform)
        let compare = Matrix3(scale: Vector2(0.3, 0.4))
        
        XCTAssertTrue(matrix ~= compare)
    }
    
    func testTranslation() {
        
        let transform = CGAffineTransformMakeTranslation(0.3, 0.4)
        let matrix = Matrix3(transform)
        let compare = Matrix3(translation: Vector2(0.3, 0.4))
        
        XCTAssertTrue(matrix ~= compare)
    }

    func testRotation() {
        
        let transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        let matrix = Matrix3(transform)
        let compare = Matrix3(rotation: .HalfPi)
        
        XCTAssertTrue(matrix ~= compare)
    }
    
    func testMatrix3Multiplication() {
        
        let a = Matrix3(rotation: .HalfPi)
        let b = Matrix3(rotation: .QuarterPi)
        let c = Matrix3(rotation: .HalfPi + .QuarterPi)
        let d = a * b
        
        XCTAssertTrue(c ~= d)
    }
    
    func testVector3Multiplication() {
        
        let m = Matrix3(rotation: .HalfPi)
        let a = Vector3(1, 0, 1)
        let b = Vector3(0, 1, 1)
        let c = a * m
        
        XCTAssertTrue(b ~= c)
    }

    func testVector2Multiplication() {
        
        let m = Matrix3(rotation: .HalfPi)
        let a = Vector2(1, 0)
        let b = Vector2(0, 1)
        let c = a * m
        
        XCTAssertTrue(b ~= c)
    }
}

class Matrix4Tests: XCTestCase {
    
    func testScale() {
        
        let transform = CATransform3DMakeScale(0.3, 0.4, 0.5)
        let matrix = Matrix4(transform)
        let compare = Matrix4(scale: Vector3(0.3, 0.4, 0.5))
        
        XCTAssertTrue(matrix ~= compare)
    }
    
    func testTranslation() {
        
        let transform = CATransform3DMakeTranslation(0.3, 0.4, 0.5)
        let matrix = Matrix4(transform)
        let compare = Matrix4(translation: Vector3(0.3, 0.4, 0.5))
        
        XCTAssertTrue(matrix ~= compare)
    }
    
    func testRotation() {
        
        let transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 1, 0, 0)
        let matrix = Matrix4(transform)
        let compare = Matrix4(rotation: Vector4(1, 0, 0, .HalfPi))
        
        XCTAssertTrue(matrix ~= compare)
    }
    
    func testRotationAndTranslation() {
        let point = Vector4(0.0, -1.0, 0.0, 1.0);
        let euclideanTransformation = Matrix4(0.0, 1.0, 0.0, 0.0,
            -1.0, 0.0, 0.0, 0.0,
            0.0, 0.0, 0.0, 0.0,
            -1.0, 0.0, 0.0, 1.0);
        
        let result = euclideanTransformation * point;
        let expectedResult = Vector4(0.0, 0.0, 0.0, 1.0);
        
        XCTAssertTrue(result ~= expectedResult);
    }
    
    
    func testTransformationMatrixMultiplication() {
        let somePoint = Vector4(2.0, 2.0, 2.0, 1.0);
        let zAxisTransformationMaxtrix90Positive = Matrix4(0.0, 1.0, 0.0, 0.0,
            -1.0, 0.0, 0.0, 0.0,
            0.0, 0.0, 0.0, 0.0,
            0.0, 0.0, 0.0, 1.0);
        let yAxisTransformationMaxtrix90Positive = Matrix4(0.0, 0.0, 1.0, 0.0,
            0.0, 1.0, 0.0, 0.0,
            -1.0, 0.0, 0.0, 0.0,
            0.0, 0.0, 0.0, 1.0);
        let xAxisTransformationMaxtrix90Positive = Matrix4(1.0, 0.0, 0.0, 0.0,
            0.0, 0.0, -1.0, 0.0,
            0.0, 1.0, 0.0, 0.0,
            0.0, 0.0, 0.0, 1.0);
        
        let resultPoint = (xAxisTransformationMaxtrix90Positive * (yAxisTransformationMaxtrix90Positive * (zAxisTransformationMaxtrix90Positive * somePoint)));
        
        let comparePoint = (xAxisTransformationMaxtrix90Positive * yAxisTransformationMaxtrix90Positive * zAxisTransformationMaxtrix90Positive) * somePoint;
        
        XCTAssertTrue(resultPoint ~= comparePoint);
    }
}

class QuaternionTests: XCTestCase {
    
    func testAxisAngleConversion() {
        
        let aaa = Vector4(1, 0, 0, .HalfPi)
        let q = Quaternion(axisAngle: aaa)
        let aab = q.toAxisAngle()
        
        XCTAssertTrue(aaa ~= aab)
    }

    func testVector3Multiplication() {
        
        let q = Quaternion(axisAngle: Vector4(0, 0, 1, .HalfPi))
        let a = Vector3(1, 0, 1)
        let b = Vector3(0, 1, 1)
        let c = a * q
        
        XCTAssertTrue(b ~= c)
    }
}

class PerformanceTests: XCTestCase {
    
    func testMatrix3MultiplicationPerformance() {
        
        let a = Matrix3(rotation: .HalfPi)
        var b = Matrix3(translation: Vector2(1, 10))
        
        measureBlock {
            for _ in 0 ..< 100000 {
                b = a * b
            }
        }
    }
    
    func testMatrix4MultiplicationPerformance() {
        
        let a = Matrix4(rotation: Vector4(1, 0, 0, .HalfPi))
        var b = Matrix4(translation: Vector3(1, 10, 24))
        
        measureBlock {
            for _ in 0 ..< 100000 {
                b = a * b
            }
        }
    }
}