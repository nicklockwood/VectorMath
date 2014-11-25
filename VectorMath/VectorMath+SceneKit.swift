//
//  VectorMath+SceneKit.swift
//  VectorMath
//
//  Version 0.1
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

import SceneKit

//MARK: SceneKit extensions

extension SCNVector3 {
    
    init(_ v: Vector3) {
        self.init(x: Float(v.x), y: Float(v.y), z: Float(v.z))
    }
}

extension SCNVector4 {
    
    init(_ v: Vector4) {
        self.init(x: Float(v.x), y: Float(v.y), z: Float(v.z), w: Float(v.w))
    }
}

extension SCNMatrix4 {
    
    init(_ m: Matrix4) {
        
        self.init(
            m11: Float(m.m11), m12: Float(m.m12), m13: Float(m.m13), m14: Float(m.m14),
            m21: Float(m.m21), m22: Float(m.m22), m23: Float(m.m23), m24: Float(m.m24),
            m31: Float(m.m31), m32: Float(m.m32), m33: Float(m.m33), m34: Float(m.m34),
            m41: Float(m.m41), m42: Float(m.m42), m43: Float(m.m43), m44: Float(m.m44)
        )
    }
}

extension SCNQuaternion {
    
    init(_ q:Quaternion) {
        self.init(x: Float(q.x), y: Float(q.y), z: Float(q.z), w: Float(q.w))
    }
}

//MARK: VectorMath extensions

extension Vector3 {
    
    init(_ v: SCNVector3) {
        self.init(x: Scalar(v.x), y: Scalar(v.y), z: Scalar(v.z))
    }
}

extension Vector4 {
    
    init(_ v: SCNVector4) {
        self.init(x: Scalar(v.x), y: Scalar(v.y), z: Scalar(v.z), w: Scalar(v.w))
    }
}

extension Matrix4 {
    
    init(_ m: SCNMatrix4) {
        
        self.init(
            m11: Scalar(m.m11), m12: Scalar(m.m12), m13: Scalar(m.m13), m14: Scalar(m.m14),
            m21: Scalar(m.m21), m22: Scalar(m.m22), m23: Scalar(m.m23), m24: Scalar(m.m24),
            m31: Scalar(m.m31), m32: Scalar(m.m32), m33: Scalar(m.m33), m34: Scalar(m.m34),
            m41: Scalar(m.m41), m42: Scalar(m.m42), m43: Scalar(m.m43), m44: Scalar(m.m44)
        )
    }
}

extension Quaternion {
    
    init(_ q: SCNQuaternion) {
        self.init(x: Scalar(q.x), y: Scalar(q.y), z: Scalar(q.z), w: Scalar(q.w))
    }
}