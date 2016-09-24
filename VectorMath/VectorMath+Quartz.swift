//
//  VectorMath+Quartz.swift
//  VectorMath
//
//  Version 0.3
//
//  Created by Nick Lockwood on 24/11/2014.
//  Copyright (c) 2014 Nick Lockwood. All rights reserved.
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/VectorMath
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

import QuartzCore

//MARK: SceneKit extensions

extension CGPoint {
    init(_ v: Vector2) {
        self.init(x: CGFloat(v.x), y: CGFloat(v.y))
    }
}

extension CGSize {
    init(_ v: Vector2) {
        self.init(width: CGFloat(v.x), height: CGFloat(v.y))
    }
}

extension CGVector {
    init(_ v: Vector2) {
        self.init(dx: CGFloat(v.x), dy: CGFloat(v.y))
    }
}

extension CGAffineTransform {
    init(_ m: Matrix3) {
        self.init(
            a: CGFloat(m.m11), b: CGFloat(m.m12),
            c: CGFloat(m.m21), d: CGFloat(m.m22),
            tx: CGFloat(m.m31), ty: CGFloat(m.m32)
        )
    }
}

extension CATransform3D {
    init(_ m: Matrix4) {
        self.init(
            m11: CGFloat(m.m11), m12: CGFloat(m.m12), m13: CGFloat(m.m13), m14: CGFloat(m.m14),
            m21: CGFloat(m.m21), m22: CGFloat(m.m22), m23: CGFloat(m.m23), m24: CGFloat(m.m24),
            m31: CGFloat(m.m31), m32: CGFloat(m.m32), m33: CGFloat(m.m33), m34: CGFloat(m.m34),
            m41: CGFloat(m.m41), m42: CGFloat(m.m42), m43: CGFloat(m.m43), m44: CGFloat(m.m44)
        )
    }
}

//MARK: VectorMath extensions

extension Vector2 {
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

extension Matrix3 {
    init(_ m: CGAffineTransform) {
        self.init(
            m11: Scalar(m.a), m12: Scalar(m.b), m13: 0,
            m21: Scalar(m.c), m22: Scalar(m.d), m23: 0,
            m31: Scalar(m.tx), m32: Scalar(m.ty), m33: 1
        )
    }
}

extension Matrix4 {
    init(_ m: CATransform3D) {
        self.init(
            m11: Scalar(m.m11), m12: Scalar(m.m12), m13: Scalar(m.m13), m14: Scalar(m.m14),
            m21: Scalar(m.m21), m22: Scalar(m.m22), m23: Scalar(m.m23), m24: Scalar(m.m24),
            m31: Scalar(m.m31), m32: Scalar(m.m32), m33: Scalar(m.m33), m34: Scalar(m.m34),
            m41: Scalar(m.m41), m42: Scalar(m.m42), m43: Scalar(m.m43), m44: Scalar(m.m44)
        )
    }
}
