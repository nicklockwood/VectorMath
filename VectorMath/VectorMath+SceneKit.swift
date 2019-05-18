//
//  VectorMath+SceneKit.swift
//  VectorMath
//
//  Version 0.4.0
//
//  Created by Nick Lockwood on 24/11/2014.
//  Copyright (c) 2014 Nick Lockwood. All rights reserved.
//
//  Distributed under the permissive MIT License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/VectorMath
///
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

#if canImport(SceneKit)

#if os(iOS) || os(tvOS)
typealias SCNFloat = Float
#else
typealias SCNFloat = CGFloat
#endif

import SceneKit

// MARK: SceneKit extensions

public extension SCNVector3 {
    init(_ v: Vector3) {
        self.init(x: SCNFloat(v.x), y: SCNFloat(v.y), z: SCNFloat(v.z))
    }
}

public extension SCNVector4 {
    init(_ v: Vector4) {
        self.init(x: SCNFloat(v.x), y: SCNFloat(v.y), z: SCNFloat(v.z), w: SCNFloat(v.w))
    }
}

#if os(iOS) // SCNMatrix4 = CATransform3D on Mac

public extension SCNMatrix4 {
    init(_ m: Matrix4) {
        self.init(
            m11: SCNFloat(m.m11), m12: SCNFloat(m.m12), m13: SCNFloat(m.m13), m14: SCNFloat(m.m14),
            m21: SCNFloat(m.m21), m22: SCNFloat(m.m22), m23: SCNFloat(m.m23), m24: SCNFloat(m.m24),
            m31: SCNFloat(m.m31), m32: SCNFloat(m.m32), m33: SCNFloat(m.m33), m34: SCNFloat(m.m34),
            m41: SCNFloat(m.m41), m42: SCNFloat(m.m42), m43: SCNFloat(m.m43), m44: SCNFloat(m.m44)
        )
    }
}

#endif

public extension SCNQuaternion {
    init(_ q: Quaternion) {
        self.init(x: SCNFloat(q.x), y: SCNFloat(q.y), z: SCNFloat(q.z), w: SCNFloat(q.w))
    }
}

// MARK: VectorMath extensions

public extension Vector3 {
    init(_ v: SCNVector3) {
        self.init(x: Scalar(v.x), y: Scalar(v.y), z: Scalar(v.z))
    }
}

public extension Vector4 {
    init(_ v: SCNVector4) {
        self.init(x: Scalar(v.x), y: Scalar(v.y), z: Scalar(v.z), w: Scalar(v.w))
    }
}

#if os(iOS) // SCNMatrix4 = CATransform3D on Mac

public extension Matrix4 {
    init(_ m: SCNMatrix4) {
        self.init(
            m11: Scalar(m.m11), m12: Scalar(m.m12), m13: Scalar(m.m13), m14: Scalar(m.m14),
            m21: Scalar(m.m21), m22: Scalar(m.m22), m23: Scalar(m.m23), m24: Scalar(m.m24),
            m31: Scalar(m.m31), m32: Scalar(m.m32), m33: Scalar(m.m33), m34: Scalar(m.m34),
            m41: Scalar(m.m41), m42: Scalar(m.m42), m43: Scalar(m.m43), m44: Scalar(m.m44)
        )
    }
}

#endif

public extension Quaternion {
    init(_ q: SCNQuaternion) {
        self.init(x: Scalar(q.x), y: Scalar(q.y), z: Scalar(q.z), w: Scalar(q.w))
    }
}

#endif
