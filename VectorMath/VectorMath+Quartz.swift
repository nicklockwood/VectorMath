//
//  VectorMath+Quartz.swift
//  VectorMath
//
//  Version 0.3.3
//
//  Created by Nick Lockwood on 24/11/2014.
//  Copyright (c) 2014 Nick Lockwood. All rights reserved.
//
//  Distributed under the permissive MIT License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/VectorMath
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#if canImport(QuartzCore)

import QuartzCore

// MARK: SceneKit extensions

public extension CGPoint {
    init(_ v: Vector2) {
        self.init(x: CGFloat(v.x), y: CGFloat(v.y))
    }
}

public extension CGSize {
    init(_ v: Vector2) {
        self.init(width: CGFloat(v.x), height: CGFloat(v.y))
    }
}

public extension CGVector {
    init(_ v: Vector2) {
        self.init(dx: CGFloat(v.x), dy: CGFloat(v.y))
    }
}

public extension CGAffineTransform {
    init(_ m: Matrix3) {
        self.init(
            a: CGFloat(m.m11), b: CGFloat(m.m12),
            c: CGFloat(m.m21), d: CGFloat(m.m22),
            tx: CGFloat(m.m31), ty: CGFloat(m.m32)
        )
    }
}

public extension CATransform3D {
    init(_ m: Matrix4) {
        self.init(
            m11: CGFloat(m.m11), m12: CGFloat(m.m12), m13: CGFloat(m.m13), m14: CGFloat(m.m14),
            m21: CGFloat(m.m21), m22: CGFloat(m.m22), m23: CGFloat(m.m23), m24: CGFloat(m.m24),
            m31: CGFloat(m.m31), m32: CGFloat(m.m32), m33: CGFloat(m.m33), m34: CGFloat(m.m34),
            m41: CGFloat(m.m41), m42: CGFloat(m.m42), m43: CGFloat(m.m43), m44: CGFloat(m.m44)
        )
    }
}

// MARK: VectorMath extensions

public extension Vector2 {
    init(_ v: CGPoint) {
        self.init(x: Scalar(v.x), y: Scalar(v.y))
    }

    init(_ v: CGSize) {
        self.init(x: Scalar(v.width), y: Scalar(v.height))
    }

    init(_ v: CGVector) {
        self.init(x: Scalar(v.dx), y: Scalar(v.dy))
    }
}

public extension Matrix3 {
    init(_ m: CGAffineTransform) {
        self.init(
            m11: Scalar(m.a), m12: Scalar(m.b), m13: 0,
            m21: Scalar(m.c), m22: Scalar(m.d), m23: 0,
            m31: Scalar(m.tx), m32: Scalar(m.ty), m33: 1
        )
    }
}

public extension Matrix4 {
    init(_ m: CATransform3D) {
        self.init(
            m11: Scalar(m.m11), m12: Scalar(m.m12), m13: Scalar(m.m13), m14: Scalar(m.m14),
            m21: Scalar(m.m21), m22: Scalar(m.m22), m23: Scalar(m.m23), m24: Scalar(m.m24),
            m31: Scalar(m.m31), m32: Scalar(m.m32), m33: Scalar(m.m33), m34: Scalar(m.m34),
            m41: Scalar(m.m41), m42: Scalar(m.m42), m43: Scalar(m.m43), m44: Scalar(m.m44)
        )
    }
}

#endif
