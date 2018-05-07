//
//  VectorMathTests.swift
//  VectorMathTests
//
//  Created by Nick Lockwood on 24/11/2014.
//  Copyright (c) 2014 Nick Lockwood. All rights reserved.
//

#if canImport(QuartzCore)
import QuartzCore

import XCTest

#if SWIFT_PACKAGE
@testable import VectorMath
#endif

class Matrix3QuartzTests: XCTestCase {

    func testScale() {
        
        let transform = CGAffineTransform(scaleX: 0.3, y: 0.4)
        let matrix = Matrix3(transform)
        let compare = Matrix3(scale: Vector2(0.3, 0.4))
        
        XCTAssertTrue(matrix ~= compare)
    }
    
    func testTranslation() {
        
        let transform = CGAffineTransform(translationX: 0.3, y: 0.4)
        let matrix = Matrix3(transform)
        let compare = Matrix3(translation: Vector2(0.3, 0.4))
        
        XCTAssertTrue(matrix ~= compare)
    }
    
    func testRotation() {
        
        let transform = CGAffineTransform(rotationAngle: .pi / 2)
        let matrix = Matrix3(transform)
        let compare = Matrix3(rotation: .halfPi)
        
        XCTAssertTrue(matrix ~= compare)
    }
}

class Matrix4QuartzTests: XCTestCase {
    
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
        
        let transform = CATransform3DMakeRotation(.pi / 2, 1, 0, 0)
        let matrix = Matrix4(transform)
        let compare = Matrix4(rotation: Vector4(1, 0, 0, .halfPi))
        
        XCTAssertTrue(matrix ~= compare)
    }
}

#endif