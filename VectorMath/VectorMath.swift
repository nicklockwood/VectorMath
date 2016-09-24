//
//  VectorMath.swift
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


import Foundation

//MARK: Types

public typealias Scalar = Float

public struct Vector2 {
    public var x: Scalar
    public var y: Scalar
}

public struct Vector3 {
    public var x: Scalar
    public var y: Scalar
    public var z: Scalar
}

public struct Vector4 {
    public var x: Scalar
    public var y: Scalar
    public var z: Scalar
    public var w: Scalar
}

public struct Matrix3 {
    public var m11: Scalar
    public var m12: Scalar
    public var m13: Scalar
    public var m21: Scalar
    public var m22: Scalar
    public var m23: Scalar
    public var m31: Scalar
    public var m32: Scalar
    public var m33: Scalar
}

public struct Matrix4 {
    public var m11: Scalar
    public var m12: Scalar
    public var m13: Scalar
    public var m14: Scalar
    public var m21: Scalar
    public var m22: Scalar
    public var m23: Scalar
    public var m24: Scalar
    public var m31: Scalar
    public var m32: Scalar
    public var m33: Scalar
    public var m34: Scalar
    public var m41: Scalar
    public var m42: Scalar
    public var m43: Scalar
    public var m44: Scalar
}

public struct Quaternion {
    public var x: Scalar
    public var y: Scalar
    public var z: Scalar
    public var w: Scalar
}

//MARK: Scalar

public extension Scalar {
    public static let pi = Scalar(M_PI)
    public static let halfPi = Scalar(M_PI_2)
    public static let quarterPi = Scalar(M_PI_4)
    public static let twoPi = Scalar(M_PI * 2)
    public static let degreesPerRadian = 180 / pi
    public static let radiansPerDegree = pi / 180
    public static let epsilon: Scalar = 0.0001
    
    public static func ~=(lhs: Scalar, rhs: Scalar) -> Bool {
        return abs(lhs - rhs) < .epsilon
    }
}

//MARK: Vector2

extension Vector2: Equatable, Hashable {
    public static let zero = Vector2(0, 0)
    public static let x = Vector2(1, 0)
    public static let y = Vector2(0, 1)
    
    public var hashValue: Int {
        return x.hashValue &+ y.hashValue
    }
    
    public var lengthSquared: Scalar {
        return x * x + y * y
    }
    
    public var length: Scalar {
        return sqrt(lengthSquared)
    }
    
    public var inverse: Vector2 {
        return -self
    }
    
    public init(_ x: Scalar, _ y: Scalar) {
        self.init(x: x, y: y)
    }
    
    public init(_ v: [Scalar]) {
        assert(v.count == 2, "array must contain 2 elements, contained \(v.count)")
        self.init(v[0], v[1])
    }
    
    public func toArray() -> [Scalar] {
        return [x, y]
    }
    
    public func dot(_ v: Vector2) -> Scalar {
        return x * v.x + y * v.y
    }
    
    public func cross(_ v: Vector2) -> Scalar {
        return x * v.y - y * v.x
    }
    
    public func normalized() -> Vector2 {
        let lengthSquared = self.lengthSquared
        if lengthSquared ~= 0 || lengthSquared ~= 1 {
            return self
        }
        return self / sqrt(lengthSquared)
    }
    
    public func rotated(by radians: Scalar) -> Vector2 {
        let cs = cos(radians)
        let sn = sin(radians)
        return Vector2(x * cs - y * sn, x * sn + y * cs)
    }
    
    public func rotated(by radians: Scalar, around pivot: Vector2) -> Vector2 {
        return (self - pivot).rotated(by: radians) + pivot
    }
    
    public func angle(with v: Vector2) -> Scalar {
        if self == v {
            return 0
        }
        
        let t1 = normalized()
        let t2 = v.normalized()
        let cross = t1.cross(t2)
        let dot = max(-1, min(1, t1.dot(t2)))
        
        return atan2(cross, dot)
    }
    
    public func interpolated(with v: Vector2, by t: Scalar) -> Vector2 {
        return self + (v - self) * t
    }
    
    public static prefix func -(v: Vector2) -> Vector2 {
        return Vector2(-v.x, -v.y)
    }
    
    public static func +(lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(lhs.x + rhs.x, lhs.y + rhs.y)
    }
    
    public static func -(lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(lhs.x - rhs.x, lhs.y - rhs.y)
    }
    
    public static func *(lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(lhs.x * rhs.x, lhs.y * rhs.y)
    }
    
    public static func *(lhs: Vector2, rhs: Scalar) -> Vector2 {
        return Vector2(lhs.x * rhs, lhs.y * rhs)
    }
    
    public static func *(lhs: Vector2, rhs: Matrix3) -> Vector2 {
        return Vector2(
            lhs.x * rhs.m11 + lhs.y * rhs.m21 + rhs.m31,
            lhs.x * rhs.m12 + lhs.y * rhs.m22 + rhs.m32
        )
    }
    
    public static func /(lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(lhs.x / rhs.x, lhs.y / rhs.y)
    }
    
    public static func /(lhs: Vector2, rhs: Scalar) -> Vector2 {
        return Vector2(lhs.x / rhs, lhs.y / rhs)
    }
    
    public static func ==(lhs: Vector2, rhs: Vector2) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    public static func ~=(lhs: Vector2, rhs: Vector2) -> Bool {
        return lhs.x ~= rhs.x && lhs.y ~= rhs.y
    }
}

//MARK: Vector3

extension Vector3: Equatable, Hashable {
    public static let zero = Vector3(0, 0, 0)
    public static let x = Vector3(1, 0, 0)
    public static let y = Vector3(0, 1, 0)
    public static let z = Vector3(0, 0, 1)
    
    public var hashValue: Int {
        return x.hashValue &+ y.hashValue &+ z.hashValue
    }
    
    public var lengthSquared: Scalar {
        return x * x + y * y + z * z
    }
    
    public var length: Scalar {
        return sqrt(lengthSquared)
    }
    
    public var inverse: Vector3 {
        return -self
    }
    
    public var xy: Vector2 {
        get {
            return Vector2(x, y)
        }
        set (v) {
            x = v.x
            y = v.y
        }
    }
    
    public var xz: Vector2 {
        get {
            return Vector2(x, z)
        }
        set (v) {
            x = v.x
            z = v.y
        }
    }
    
    public var yz: Vector2 {
        get {
            return Vector2(y, z)
        }
        set (v) {
            y = v.x
            z = v.y
        }
    }
    
    public init(_ x: Scalar, _ y: Scalar, _ z: Scalar) {
        self.init(x: x, y: y, z: z)
    }
    
    public init(_ v: [Scalar]) {
        assert(v.count == 3, "array must contain 3 elements, contained \(v.count)")
        self.init(v[0], v[1], v[2])
    }
    
    public func toArray() -> [Scalar] {
        return [x, y, z]
    }
    
    public func dot(_ v: Vector3) -> Scalar {
        return x * v.x + y * v.y + z * v.z
    }
    
    public func cross(_ v: Vector3) -> Vector3 {
        return Vector3(y * v.z - z * v.y, z * v.x - x * v.z, x * v.y - y * v.x)
    }
    
    public func normalized() -> Vector3 {
        let lengthSquared = self.lengthSquared
        if lengthSquared ~= 0 || lengthSquared ~= 1 {
            return self
        }
        return self / sqrt(lengthSquared)
    }

    public func interpolated(with v: Vector3, by t: Scalar) -> Vector3 {
        return self + (v - self) * t
    }
    
    public static prefix func -(v: Vector3) -> Vector3 {
        return Vector3(-v.x, -v.y, -v.z)
    }
    
    public static func +(lhs: Vector3, rhs: Vector3) -> Vector3 {
        return Vector3(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
    }
    
    public static func -(lhs: Vector3, rhs: Vector3) -> Vector3 {
        return Vector3(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
    }
    
    public static func *(lhs: Vector3, rhs: Vector3) -> Vector3 {
        return Vector3(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z)
    }
    
    public static func *(lhs: Vector3, rhs: Scalar) -> Vector3 {
        return Vector3(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs)
    }
    
    public static func *(lhs: Vector3, rhs: Matrix3) -> Vector3 {
        return Vector3(
            lhs.x * rhs.m11 + lhs.y * rhs.m21 + lhs.z * rhs.m31,
            lhs.x * rhs.m12 + lhs.y * rhs.m22 + lhs.z * rhs.m32,
            lhs.x * rhs.m13 + lhs.y * rhs.m23 + lhs.z * rhs.m33
        )
    }
    
    public static func *(lhs: Vector3, rhs: Matrix4) -> Vector3 {
        return Vector3(
            lhs.x * rhs.m11 + lhs.y * rhs.m21 + lhs.z * rhs.m31 + rhs.m41,
            lhs.x * rhs.m12 + lhs.y * rhs.m22 + lhs.z * rhs.m32 + rhs.m42,
            lhs.x * rhs.m13 + lhs.y * rhs.m23 + lhs.z * rhs.m33 + rhs.m43
        )
    }
    
    public static func *(v: Vector3, q: Quaternion) -> Vector3 {
        let qv = q.xyz
        let uv = qv.cross(v)
        let uuv = qv.cross(uv)
        return v + (uv * 2 * q.w) + (uuv * 2)
    }
    
    public static func /(lhs: Vector3, rhs: Vector3) -> Vector3 {
        return Vector3(lhs.x / rhs.x, lhs.y / rhs.y, lhs.z / rhs.z)
    }
    
    public static func /(lhs: Vector3, rhs: Scalar) -> Vector3 {
        return Vector3(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs)
    }
    
    public static func ==(lhs: Vector3, rhs: Vector3) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
    
    public static func ~=(lhs: Vector3, rhs: Vector3) -> Bool {
        return lhs.x ~= rhs.x && lhs.y ~= rhs.y && lhs.z ~= rhs.z
    }
}

//MARK: Vector4

extension Vector4: Equatable, Hashable {
    public static let zero = Vector4(0, 0, 0, 0)
    public static let x = Vector4(1, 0, 0, 0)
    public static let y = Vector4(0, 1, 0, 0)
    public static let z = Vector4(0, 0, 1, 0)
    public static let w = Vector4(0, 0, 0, 1)
    
    public var hashValue: Int {
        return x.hashValue &+ y.hashValue &+ z.hashValue &+ w.hashValue
    }
    
    public var lengthSquared: Scalar {
        return x * x + y * y + z * z + w * w
    }
    
    public var length: Scalar {
        return sqrt(lengthSquared)
    }
    
    public var inverse: Vector4 {
        return -self
    }
    
    public var xyz: Vector3 {
        get {
            return Vector3(x, y, z)
        }
        set (v) {
            x = v.x
            y = v.y
            z = v.z
        }
    }
    
    public var xy: Vector2 {
        get {
            return Vector2(x, y)
        }
        set (v) {
            x = v.x
            y = v.y
        }
    }
    
    public var xz: Vector2 {
        get {
            return Vector2(x, z)
        }
        set (v) {
            x = v.x
            z = v.y
        }
    }
    
    public var yz: Vector2 {
        get {
            return Vector2(y, z)
        }
        set (v) {
            y = v.x
            z = v.y
        }
    }
    
    public init(_ x: Scalar, _ y: Scalar, _ z: Scalar, _ w: Scalar) {
        self.init(x: x, y: y, z: z, w: w)
    }
    
    public init(_ v: [Scalar]) {
        assert(v.count == 4, "array must contain 4 elements, contained \(v.count)")
        self.init(v[0], v[1], v[2], v[3])
    }
    
    public init(_ v: Vector3, w: Scalar) {
        self.init(v.x, v.y, v.z, w)
    }
    
    public func toArray() -> [Scalar] {
        return [x, y, z, w]
    }
    
    public func toVector3() -> Vector3 {
        if w ~= 0 {
            return xyz
        } else {
            return xyz / w
        }
    }
    
    public func dot(_ v: Vector4) -> Scalar {
        return x * v.x + y * v.y + z * v.z + w * v.w
    }
    
    public func normalized() -> Vector4 {
        let lengthSquared = self.lengthSquared
        if lengthSquared ~= 0 || lengthSquared ~= 1 {
            return self
        }
        return self / sqrt(lengthSquared)
    }
    
    public func interpolated(with v: Vector4, by t: Scalar) -> Vector4 {
        return self + (v - self) * t
    }
    
    public static prefix func -(v: Vector4) -> Vector4 {
        return Vector4(-v.x, -v.y, -v.z, -v.w)
    }
    
    public static func +(lhs: Vector4, rhs: Vector4) -> Vector4 {
        return Vector4(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w)
    }
    
    public static func -(lhs: Vector4, rhs: Vector4) -> Vector4 {
        return Vector4(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w)
    }
    
    public static func *(lhs: Vector4, rhs: Vector4) -> Vector4 {
        return Vector4(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z, lhs.w * rhs.w)
    }
    
    public static func *(lhs: Vector4, rhs: Scalar) -> Vector4 {
        return Vector4(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs)
    }
    
    public static func *(lhs: Vector4, rhs: Matrix4) -> Vector4 {
        return Vector4(
            lhs.x * rhs.m11 + lhs.y * rhs.m21 + lhs.z * rhs.m31 + lhs.w * rhs.m41,
            lhs.x * rhs.m12 + lhs.y * rhs.m22 + lhs.z * rhs.m32 + lhs.w * rhs.m42,
            lhs.x * rhs.m13 + lhs.y * rhs.m23 + lhs.z * rhs.m33 + lhs.w * rhs.m43,
            lhs.x * rhs.m14 + lhs.y * rhs.m24 + lhs.z * rhs.m34 + lhs.w * rhs.m44
        )
    }
    
    public static func /(lhs: Vector4, rhs: Vector4) -> Vector4 {
        return Vector4(lhs.x / rhs.x, lhs.y / rhs.y, lhs.z / rhs.z, lhs.w / rhs.w)
    }
    
    public static func /(lhs: Vector4, rhs: Scalar) -> Vector4 {
        return Vector4(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs)
    }
    
    public static func ==(lhs: Vector4, rhs: Vector4) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z && lhs.w == rhs.w
    }
    
    public static func ~=(lhs: Vector4, rhs: Vector4) -> Bool {
        return lhs.x ~= rhs.x && lhs.y ~= rhs.y && lhs.z ~= rhs.z && lhs.w ~= rhs.w
    }
}

//MARK: Matrix3

extension Matrix3: Equatable, Hashable {
    public static let identity = Matrix3(1, 0 ,0 ,0, 1, 0, 0, 0, 1)
    
    public var hashValue: Int {
        var hash = m11.hashValue &+ m12.hashValue &+ m13.hashValue
        hash = hash &+ m21.hashValue &+ m22.hashValue &+ m23.hashValue
        hash = hash &+ m31.hashValue &+ m32.hashValue &+ m33.hashValue
        return hash
    }
    
    public init(_ m11: Scalar, _ m12: Scalar, _ m13: Scalar,
        _ m21: Scalar, _ m22: Scalar, _ m23: Scalar,
        _ m31: Scalar, _ m32: Scalar, _ m33: Scalar) {
            
        self.m11 = m11 // 0
        self.m12 = m12 // 1
        self.m13 = m13 // 2
        self.m21 = m21 // 3
        self.m22 = m22 // 4
        self.m23 = m23 // 5
        self.m31 = m31 // 6
        self.m32 = m32 // 7
        self.m33 = m33 // 8
    }
    
    public init(scale: Vector2) {
        self.init(
            scale.x, 0, 0,
            0, scale.y, 0,
            0, 0, 1
        )
    }
    
    public init(translation: Vector2) {
        self.init(
            1, 0, 0,
            0, 1, 0,
            translation.x, translation.y, 1
        )
    }
    
    public init(rotation radians: Scalar) {
        let cs = cos(radians)
        let sn = sin(radians)
        self.init(
            cs, sn, 0,
            -sn, cs, 0,
            0, 0, 1
        )
    }
    
    public init(_ m: [Scalar]) {
        assert(m.count == 9, "array must contain 9 elements, contained \(m.count)")
        self.init(m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8])
    }
    
    public func toArray() -> [Scalar] {
        return [m11, m12, m13, m21, m22, m23, m31, m32, m33]
    }
    
    public var adjugate: Matrix3 {
        return Matrix3(
            m22 * m33 - m23 * m32,
            m13 * m32 - m12 * m33,
            m12 * m23 - m13 * m22,
            m23 * m31 - m21 * m33,
            m11 * m33 - m13 * m31,
            m13 * m21 - m11 * m23,
            m21 * m32 - m22 * m31,
            m12 * m31 - m11 * m32,
            m11 * m22 - m12 * m21
        )
    }
    
    public var determinant: Scalar {
        return (m11 * m22 * m33 + m12 * m23 * m31 + m13 * m21 * m32)
            - (m13 * m22 * m31 + m11 * m23 * m32 + m12 * m21 * m33)
    }
    
    public var transpose: Matrix3 {
        return Matrix3(m11, m21, m31, m12, m22, m32, m13, m23, m33)
    }
    
    public var inverse: Matrix3 {
        return adjugate * (1 / determinant)
    }

    public func interpolated(with m: Matrix3, by t: Scalar) -> Matrix3 {
        return Matrix3(
            m11 + (m.m11 - m11) * t,
            m12 + (m.m12 - m12) * t,
            m13 + (m.m13 - m13) * t,
            m21 + (m.m21 - m21) * t,
            m22 + (m.m22 - m22) * t,
            m23 + (m.m23 - m23) * t,
            m31 + (m.m31 - m31) * t,
            m32 + (m.m32 - m32) * t,
            m33 + (m.m33 - m33) * t
        )
    }
    
    public static prefix func -(m: Matrix3) -> Matrix3 {
        return m.inverse
    }
    
    public static func *(lhs: Matrix3, rhs: Matrix3) -> Matrix3 {
        return Matrix3(
            lhs.m11 * rhs.m11 + lhs.m21 * rhs.m12 + lhs.m31 * rhs.m13,
            lhs.m12 * rhs.m11 + lhs.m22 * rhs.m12 + lhs.m32 * rhs.m13,
            lhs.m13 * rhs.m11 + lhs.m23 * rhs.m12 + lhs.m33 * rhs.m13,
            lhs.m11 * rhs.m21 + lhs.m21 * rhs.m22 + lhs.m31 * rhs.m23,
            lhs.m12 * rhs.m21 + lhs.m22 * rhs.m22 + lhs.m32 * rhs.m23,
            lhs.m13 * rhs.m21 + lhs.m23 * rhs.m22 + lhs.m33 * rhs.m23,
            lhs.m11 * rhs.m31 + lhs.m21 * rhs.m32 + lhs.m31 * rhs.m33,
            lhs.m12 * rhs.m31 + lhs.m22 * rhs.m32 + lhs.m32 * rhs.m33,
            lhs.m13 * rhs.m31 + lhs.m23 * rhs.m32 + lhs.m33 * rhs.m33
        )
    }
    
    public static func *(lhs: Matrix3, rhs: Vector2) -> Vector2 {
        return rhs * lhs
    }
    
    public static func *(lhs: Matrix3, rhs: Vector3) -> Vector3 {
        return rhs * lhs
    }
    
    public static func *(lhs: Matrix3, rhs: Scalar) -> Matrix3 {
        return Matrix3(
            lhs.m11 * rhs, lhs.m12 * rhs, lhs.m13 * rhs,
            lhs.m21 * rhs, lhs.m22 * rhs, lhs.m23 * rhs,
            lhs.m31 * rhs, lhs.m32 * rhs, lhs.m33 * rhs
        )
    }
    
    public static func ==(lhs: Matrix3, rhs: Matrix3) -> Bool {
        if lhs.m11 != rhs.m11 { return false }
        if lhs.m12 != rhs.m12 { return false }
        if lhs.m13 != rhs.m13 { return false }
        if lhs.m21 != rhs.m21 { return false }
        if lhs.m22 != rhs.m22 { return false }
        if lhs.m23 != rhs.m23 { return false }
        if lhs.m31 != rhs.m31 { return false }
        if lhs.m32 != rhs.m32 { return false }
        if lhs.m33 != rhs.m33 { return false }
        return true
    }
    
    public static func ~=(lhs: Matrix3, rhs: Matrix3) -> Bool {
        if !(lhs.m11 ~= rhs.m11) { return false }
        if !(lhs.m12 ~= rhs.m12) { return false }
        if !(lhs.m13 ~= rhs.m13) { return false }
        if !(lhs.m21 ~= rhs.m21) { return false }
        if !(lhs.m22 ~= rhs.m22) { return false }
        if !(lhs.m23 ~= rhs.m23) { return false }
        if !(lhs.m31 ~= rhs.m31) { return false }
        if !(lhs.m32 ~= rhs.m32) { return false }
        if !(lhs.m33 ~= rhs.m33) { return false }
        return true
    }
}

//MARK: Matrix4

extension Matrix4: Equatable, Hashable {
    public static let identity = Matrix4(1, 0 ,0 ,0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
    
    public var hashValue: Int {
        var hash = m11.hashValue &+ m12.hashValue &+ m13.hashValue &+ m14.hashValue
        hash = hash &+ m21.hashValue &+ m22.hashValue &+ m23.hashValue &+ m24.hashValue
        hash = hash &+ m31.hashValue &+ m32.hashValue &+ m33.hashValue &+ m34.hashValue
        hash = hash &+ m41.hashValue &+ m42.hashValue &+ m43.hashValue &+ m44.hashValue
        return hash
    }
    
    public init(_ m11: Scalar, _ m12: Scalar, _ m13: Scalar, _ m14: Scalar,
        _ m21: Scalar, _ m22: Scalar, _ m23: Scalar, _ m24: Scalar,
        _ m31: Scalar, _ m32: Scalar, _ m33: Scalar, _ m34: Scalar,
        _ m41: Scalar, _ m42: Scalar, _ m43: Scalar, _ m44: Scalar) {
            
        self.m11 = m11 // 0
        self.m12 = m12 // 1
        self.m13 = m13 // 2
        self.m14 = m14 // 3
        self.m21 = m21 // 4
        self.m22 = m22 // 5
        self.m23 = m23 // 6
        self.m24 = m24 // 7
        self.m31 = m31 // 8
        self.m32 = m32 // 9
        self.m33 = m33 // 10
        self.m34 = m34 // 11
        self.m41 = m41 // 12
        self.m42 = m42 // 13
        self.m43 = m43 // 14
        self.m44 = m44 // 15
    }
    
    public init(scale s: Vector3) {
        self.init(
            s.x, 0, 0, 0,
            0, s.y, 0, 0,
            0, 0, s.z, 0,
            0, 0, 0, 1
        )
    }
    
    public init(translation t: Vector3) {
        self.init(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            t.x, t.y, t.z, 1
        )
    }
    
    public init(rotation axisAngle: Vector4) {
        self.init(quaternion: Quaternion(axisAngle: axisAngle))
    }
    
    public init(quaternion q: Quaternion) {
        self.init(
            1 - 2 * (q.y * q.y + q.z * q.z), 2 * (q.x * q.y + q.z * q.w), 2 * (q.x * q.z - q.y * q.w), 0,
            2 * (q.x * q.y - q.z * q.w), 1 - 2 * (q.x * q.x + q.z * q.z), 2 * (q.y * q.z + q.x * q.w), 0,
            2 * (q.x * q.z + q.y * q.w), 2 * (q.y * q.z - q.x * q.w), 1 - 2 * (q.x * q.x + q.y * q.y), 0,
            0, 0, 0, 1
        )
    }
    
    public init(fovx: Scalar, fovy: Scalar, near: Scalar, far: Scalar) {
        self.init(fovy: fovy, aspect: fovx / fovy, near: near, far: far)
    }
    
    public init(fovx: Scalar, aspect: Scalar, near: Scalar, far: Scalar) {
        self.init(fovy: fovx / aspect, aspect: aspect, near: near, far: far)
    }
    
    public init(fovy: Scalar, aspect: Scalar, near: Scalar, far: Scalar) {
        let dz = far - near
        
        assert(dz > 0, "far value must be greater than near")
        assert(fovy > 0, "field of view must be nonzero and positive")
        assert(aspect > 0, "aspect ratio must be nonzero and positive")
        
        let r = fovy / 2
        let cotangent = cos(r) / sin(r)
        
        self.init(
            cotangent / aspect, 0, 0, 0,
            0, cotangent, 0, 0,
            0, 0, -(far + near) / dz, -1,
            0, 0, -2 * near * far / dz, 0
        )
    }
    
    public init(top: Scalar, right: Scalar, bottom: Scalar, left: Scalar, near: Scalar, far: Scalar) {
        let dx = right - left
        let dy = top - bottom
        let dz = far - near
        
        self.init(
            2 / dx, 0, 0, 0,
            0, 2 / dy, 0, 0,
            0, 0, -2 / dz, 0,
            -(right + left) / dx, -(top + bottom) / dy, -(far + near) / dz, 1
        )
    }
    
    public init(_ m: [Scalar]) {
        assert(m.count == 16, "array must contain 16 elements, contained \(m.count)")
        
        m11 = m[0]
        m12 = m[1]
        m13 = m[2]
        m14 = m[3]
        m21 = m[4]
        m22 = m[5]
        m23 = m[6]
        m24 = m[7]
        m31 = m[8]
        m32 = m[9]
        m33 = m[10]
        m34 = m[11]
        m41 = m[12]
        m42 = m[13]
        m43 = m[14]
        m44 = m[15]
    }
    
    public func toArray() -> [Scalar] {
        return [m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44]
    }
    
    public var adjugate: Matrix4 {
        var m = Matrix4.identity
        
        m.m11 = m22 * m33 * m44 - m22 * m34 * m43
        m.m11 += -m32 * m23 * m44 + m32 * m24 * m43
        m.m11 += m42 * m23 * m34 - m42 * m24 * m33
        
        m.m21 = -m21 * m33 * m44 + m21 * m34 * m43
        m.m21 += m31 * m23 * m44 - m31 * m24 * m43
        m.m21 += -m41 * m23 * m34 + m41 * m24 * m33
        
        m.m31 = m21 * m32 * m44 - m21 * m34 * m42
        m.m31 += -m31 * m22 * m44 + m31 * m24 * m42
        m.m31 += m41 * m22 * m34 - m41 * m24 * m32
        
        m.m41 = -m21 * m32 * m43 + m21 * m33 * m42
        m.m41 += m31 * m22 * m43 - m31 * m23 * m42
        m.m41 += -m41 * m22 * m33 + m41 * m23 * m32
        
        m.m12 = -m12 * m33 * m44 + m12 * m34 * m43
        m.m12 += m32 * m13 * m44 - m32 * m14 * m43
        m.m12 += -m42 * m13 * m34 + m42 * m14 * m33
        
        m.m22 = m11 * m33 * m44 - m11 * m34 * m43
        m.m22 += -m31 * m13 * m44 + m31 * m14 * m43
        m.m22 += m41 * m13 * m34 - m41 * m14 * m33
        
        m.m32 = -m11 * m32 * m44 + m11 * m34 * m42
        m.m32 += m31 * m12 * m44 - m31 * m14 * m42
        m.m32 += -m41 * m12 * m34 + m41 * m14 * m32
        
        m.m42 = m11 * m32 * m43 - m11 * m33 * m42
        m.m42 += -m31 * m12 * m43 + m31 * m13 * m42
        m.m42 += m41 * m12 * m33 - m41 * m13 * m32
        
        m.m13 = m12 * m23 * m44 - m12 * m24 * m43
        m.m13 += -m22 * m13 * m44 + m22 * m14 * m43
        m.m13 += m42 * m13 * m24 - m42 * m14 * m23
        
        m.m23 = -m11 * m23 * m44 + m11 * m24 * m43
        m.m23 += m21 * m13 * m44 - m21 * m14 * m43
        m.m23 += -m41 * m13 * m24 + m41 * m14 * m23
        
        m.m33 = m11 * m22 * m44 - m11 * m24 * m42
        m.m33 += -m21 * m12 * m44 + m21 * m14 * m42
        m.m33 += m41 * m12 * m24 - m41 * m14 * m22
        
        m.m43 = -m11 * m22 * m43 + m11 * m23 * m42
        m.m43 += m21 * m12 * m43 - m21 * m13 * m42
        m.m43 += -m41 * m12 * m23 + m41 * m13 * m22
        
        m.m14 = -m12 * m23 * m34 + m12 * m24 * m33
        m.m14 += m22 * m13 * m34 - m22 * m14 * m33
        m.m14 += -m32 * m13 * m24 + m32 * m14 * m23
        
        m.m24 = m11 * m23 * m34 - m11 * m24 * m33
        m.m24 += -m21 * m13 * m34 + m21 * m14 * m33
        m.m24 += m31 * m13 * m24 - m31 * m14 * m23
        
        m.m34 = -m11 * m22 * m34 + m11 * m24 * m32
        m.m34 += m21 * m12 * m34 - m21 * m14 * m32
        m.m34 += -m31 * m12 * m24 + m31 * m14 * m22
        
        m.m44 = m11 * m22 * m33 - m11 * m23 * m32
        m.m44 += -m21 * m12 * m33 + m21 * m13 * m32
        m.m44 += m31 * m12 * m23 - m31 * m13 * m22
        
        return m
    }
    
    private func determinant(forAdjugate m: Matrix4) -> Scalar {
        return m11 * m.m11 + m12 * m.m21 + m13 * m.m31 + m14 * m.m41
    }
    
    public var determinant: Scalar {
        return determinant(forAdjugate: adjugate)
    }
    
    public var transpose: Matrix4 {
        return Matrix4(
            m11, m21, m31, m41,
            m12, m22, m32, m42,
            m13, m23, m33, m43,
            m14, m24, m34, m44
        )
    }
    
    public var inverse: Matrix4 {
        let adjugate = self.adjugate // avoid recalculating
        return adjugate * (1 / determinant(forAdjugate: adjugate))
    }
    
    public static prefix func -(m: Matrix4) -> Matrix4 {
        return m.inverse
    }
    
    public static func *(lhs: Matrix4, rhs: Matrix4) -> Matrix4 {
        var m = Matrix4.identity
        
        m.m11 = lhs.m11 * rhs.m11 + lhs.m21 * rhs.m12
        m.m11 += lhs.m31 * rhs.m13 + lhs.m41 * rhs.m14
        
        m.m12 = lhs.m12 * rhs.m11 + lhs.m22 * rhs.m12
        m.m12 += lhs.m32 * rhs.m13 + lhs.m42 * rhs.m14
        
        m.m13 = lhs.m13 * rhs.m11 + lhs.m23 * rhs.m12
        m.m13 += lhs.m33 * rhs.m13 + lhs.m43 * rhs.m14
        
        m.m14 = lhs.m14 * rhs.m11 + lhs.m24 * rhs.m12
        m.m14 += lhs.m34 * rhs.m13 + lhs.m44 * rhs.m14
        
        m.m21 = lhs.m11 * rhs.m21 + lhs.m21 * rhs.m22
        m.m21 += lhs.m31 * rhs.m23 + lhs.m41 * rhs.m24
        
        m.m22 = lhs.m12 * rhs.m21 + lhs.m22 * rhs.m22
        m.m22 += lhs.m32 * rhs.m23 + lhs.m42 * rhs.m24
        
        m.m23 = lhs.m13 * rhs.m21 + lhs.m23 * rhs.m22
        m.m23 += lhs.m33 * rhs.m23 + lhs.m43 * rhs.m24
        
        m.m24 = lhs.m14 * rhs.m21 + lhs.m24 * rhs.m22
        m.m24 += lhs.m34 * rhs.m23 + lhs.m44 * rhs.m24
        
        m.m31 = lhs.m11 * rhs.m31 + lhs.m21 * rhs.m32
        m.m31 += lhs.m31 * rhs.m33 + lhs.m41 * rhs.m34
        
        m.m32 = lhs.m12 * rhs.m31 + lhs.m22 * rhs.m32
        m.m32 += lhs.m32 * rhs.m33 + lhs.m42 * rhs.m34
        
        m.m33 = lhs.m13 * rhs.m31 + lhs.m23 * rhs.m32
        m.m33 += lhs.m33 * rhs.m33 + lhs.m43 * rhs.m34
        
        m.m34 = lhs.m14 * rhs.m31 + lhs.m24 * rhs.m32
        m.m34 += lhs.m34 * rhs.m33 + lhs.m44 * rhs.m34
        
        m.m41 = lhs.m11 * rhs.m41 + lhs.m21 * rhs.m42
        m.m41 += lhs.m31 * rhs.m43 + lhs.m41 * rhs.m44
        
        m.m42 = lhs.m12 * rhs.m41 + lhs.m22 * rhs.m42
        m.m42 += lhs.m32 * rhs.m43 + lhs.m42 * rhs.m44
        
        m.m43 = lhs.m13 * rhs.m41 + lhs.m23 * rhs.m42
        m.m43 += lhs.m33 * rhs.m43 + lhs.m43 * rhs.m44
        
        m.m44 = lhs.m14 * rhs.m41 + lhs.m24 * rhs.m42
        m.m44 += lhs.m34 * rhs.m43 + lhs.m44 * rhs.m44
        
        return m
    }
    
    public static func *(lhs: Matrix4, rhs: Vector3) -> Vector3 {
        return rhs * lhs
    }
    
    public static func *(lhs: Matrix4, rhs: Vector4) -> Vector4 {
        return rhs * lhs
    }
    
    public static func *(lhs: Matrix4, rhs: Scalar) -> Matrix4 {
        return Matrix4(
            lhs.m11 * rhs, lhs.m12 * rhs, lhs.m13 * rhs, lhs.m14 * rhs,
            lhs.m21 * rhs, lhs.m22 * rhs, lhs.m23 * rhs, lhs.m24 * rhs,
            lhs.m31 * rhs, lhs.m32 * rhs, lhs.m33 * rhs, lhs.m34 * rhs,
            lhs.m41 * rhs, lhs.m42 * rhs, lhs.m43 * rhs, lhs.m44 * rhs
        )
    }
    
    public static func ==(lhs: Matrix4, rhs: Matrix4) -> Bool {
        if lhs.m11 != rhs.m11 { return false }
        if lhs.m12 != rhs.m12 { return false }
        if lhs.m13 != rhs.m13 { return false }
        if lhs.m14 != rhs.m14 { return false }
        if lhs.m21 != rhs.m21 { return false }
        if lhs.m22 != rhs.m22 { return false }
        if lhs.m23 != rhs.m23 { return false }
        if lhs.m24 != rhs.m24 { return false }
        if lhs.m31 != rhs.m31 { return false }
        if lhs.m32 != rhs.m32 { return false }
        if lhs.m33 != rhs.m33 { return false }
        if lhs.m34 != rhs.m34 { return false }
        if lhs.m41 != rhs.m41 { return false }
        if lhs.m42 != rhs.m42 { return false }
        if lhs.m43 != rhs.m43 { return false }
        if lhs.m44 != rhs.m44 { return false }
        return true
    }
    
    public static func ~=(lhs: Matrix4, rhs: Matrix4) -> Bool {
        if !(lhs.m11 ~= rhs.m11) { return false }
        if !(lhs.m12 ~= rhs.m12) { return false }
        if !(lhs.m13 ~= rhs.m13) { return false }
        if !(lhs.m14 ~= rhs.m14) { return false }
        if !(lhs.m21 ~= rhs.m21) { return false }
        if !(lhs.m22 ~= rhs.m22) { return false }
        if !(lhs.m23 ~= rhs.m23) { return false }
        if !(lhs.m24 ~= rhs.m24) { return false }
        if !(lhs.m31 ~= rhs.m31) { return false }
        if !(lhs.m32 ~= rhs.m32) { return false }
        if !(lhs.m33 ~= rhs.m33) { return false }
        if !(lhs.m34 ~= rhs.m34) { return false }
        if !(lhs.m41 ~= rhs.m41) { return false }
        if !(lhs.m42 ~= rhs.m42) { return false }
        if !(lhs.m43 ~= rhs.m43) { return false }
        if !(lhs.m44 ~= rhs.m44) { return false }
        return true
    }
}

//MARK: Quaternion

extension Quaternion: Equatable, Hashable {
    public static let zero = Quaternion(0, 0, 0, 0)
    public static let identity = Quaternion(0, 0, 0, 1)
    
    public var hashValue: Int {
        return x.hashValue &+ y.hashValue &+ z.hashValue &+ w.hashValue
    }
    
    public var lengthSquared: Scalar {
        return x * x + y * y + z * z + w * w
    }
    
    public var length: Scalar {
        return sqrt(lengthSquared)
    }
    
    public var inverse: Quaternion {
        return -self
    }
    
    public var xyz: Vector3 {
        get {
            return Vector3(x, y, z)
        }
        set (v) {
            x = v.x
            y = v.y
            z = v.z
        }
    }
    
    public var pitch: Scalar {
        return atan2(2 * (y * z + w * x), w * w - x * x - y * y + z * z)
    }
    
    public var yaw: Scalar {
        return asin(-2 * (x * z - w * y))
    }
    
    public var roll: Scalar {
        return atan2(2 * (x * y + w * z), w * w + x * x - y * y - z * z)
    }
    
    public init(_ x: Scalar, _ y: Scalar, _ z: Scalar, _ w: Scalar) {
        self.init(x: x, y: y, z: z, w: w)
    }
    
    public init(axisAngle: Vector4) {
        let r = axisAngle.w * 0.5
        let scale = sin(r)
        let a = axisAngle.xyz * scale
        self.init(a.x, a.y, a.z, cos(r))
    }
    
    public init(pitch: Scalar, yaw: Scalar, roll: Scalar) {
        let quatPitch = Quaternion(axisAngle: Vector4(1, 0, 0, pitch))
        let quatYaw = Quaternion(axisAngle: Vector4(0, 1, 0, yaw))
        let quatRoll = Quaternion(axisAngle: Vector4(0, 0, 1, roll))
        self = quatPitch * quatYaw * quatRoll
    }
    
    public init(rotationMatrix m: Matrix4) {
        let diagonal = m.m11 + m.m22 + m.m33 + 1
        if diagonal ~= 0 {
            let scale = sqrt(diagonal) * 2
            self.init(
                (m.m32 - m.m23) / scale,
                (m.m13 - m.m31) / scale,
                (m.m21 - m.m12) / scale,
                0.25 * scale
            )
        } else if m.m11 > max(m.m22, m.m33) {
            let scale = sqrt(1 + m.m11 - m.m22 - m.m33) * 2
            self.init(
                0.25 * scale,
                (m.m21 + m.m12) / scale,
                (m.m13 + m.m31) / scale,
                (m.m32 - m.m23) / scale
            )
        } else if m.m22 > m.m33 {
            let scale = sqrt(1 + m.m22 - m.m11 - m.m33) * 2
            self.init(
                (m.m21 + m.m12) / scale,
                0.25 * scale,
                (m.m32 + m.m23) / scale,
                (m.m13 - m.m31) / scale
            )
        } else {
            let scale = sqrt(1 + m.m33 - m.m11 - m.m22) * 2
            self.init(
                (m.m13 + m.m31) / scale,
                (m.m32 + m.m23) / scale,
                0.25 * scale,
                (m.m21 - m.m12) / scale
            )
        }
    }
    
    public init(_ v: [Scalar]) {
        assert(v.count == 4, "array must contain 4 elements, contained \(v.count)")
        
        x = v[0]
        y = v[1]
        z = v[2]
        w = v[3]
    }
    
    public func toAxisAngle() -> Vector4 {
        let scale = xyz.length
        if scale ~= 0 || scale ~= .twoPi {
            return .z
        } else {
            return Vector4(x / scale, y / scale, z / scale, acos(w) * 2)
        }
    }
    
    public func toPitchYawRoll() -> (pitch: Scalar, yaw: Scalar, roll: Scalar) {
        return (pitch, yaw, roll)
    }
    
    public func toArray() -> [Scalar] {
        return [x, y, z, w]
    }
    
    public func dot(_ v: Quaternion) -> Scalar {
        return x * v.x + y * v.y + z * v.z + w * v.w
    }
    
    public func normalized() -> Quaternion {
        let lengthSquared = self.lengthSquared
        if lengthSquared ~= 0 || lengthSquared ~= 1 {
            return self
        }
        return self / sqrt(lengthSquared)
    }
    
    public func interpolated(with q: Quaternion, by t: Scalar) -> Quaternion {
        let dot = max(-1, min(1, self.dot(q)))
        if dot ~= 1 {
            return (self + (q - self) * t).normalized()
        }
        
        let theta = acos(dot) * t
        let t1 = self * cos(theta)
        let t2 = (q - (self * dot)).normalized() * sin(theta)
        return t1 + t2
    }
    
    public static prefix func -(q: Quaternion) -> Quaternion {
        return Quaternion(-q.x, -q.y, -q.z, q.w)
    }
    
    public static func +(lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w)
    }
    
    public static func -(lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w)
    }
    
    public static func *(lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(
            lhs.w * rhs.x + lhs.x * rhs.w + lhs.y * rhs.z - lhs.z * rhs.y,
            lhs.w * rhs.y + lhs.y * rhs.w + lhs.z * rhs.x - lhs.x * rhs.z,
            lhs.w * rhs.z + lhs.z * rhs.w + lhs.x * rhs.y - lhs.y * rhs.x,
            lhs.w * rhs.w - lhs.x * rhs.x - lhs.y * rhs.y - lhs.z * rhs.z
        )
    }
    
    public static func *(lhs: Quaternion, rhs: Vector3) -> Vector3 {
        return rhs * lhs
    }
    
    public static func *(lhs: Quaternion, rhs: Scalar) -> Quaternion {
        return Quaternion(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs)
    }
    
    public static func /(lhs: Quaternion, rhs: Scalar) -> Quaternion {
        return Quaternion(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs)
    }
    
    public static func ==(lhs: Quaternion, rhs: Quaternion) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z && lhs.w == rhs.w
    }
    
    public static func ~=(lhs: Quaternion, rhs: Quaternion) -> Bool {
        return lhs.x ~= rhs.x && lhs.y ~= rhs.y && lhs.z ~= rhs.z && lhs.w ~= rhs.w
    }
}
