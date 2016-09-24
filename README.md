[![Travis](https://img.shields.io/travis/nicklockwood/VectorMath.svg?maxAge=2592000)](https://travis-ci.org/nicklockwood/VectorMath)
[![License](https://img.shields.io/badge/license-zlib-lightgrey.svg?maxAge=2592000)](https://opensource.org/licenses/Zlib)
[![Twitter](https://img.shields.io/badge/twitter-@nicklockwood-blue.svg?maxAge=2592000)](http://twitter.com/nicklockwood)


Purpose
--------------

VectorMath is a Swift library for Mac and iOS that implements common 2D and 3D vector and matrix functions, useful for games or vector-based graphics.

VectorMath takes advantage of Swift language features such as function and operator overloading and struct methods to provide a more elegant interface than most C, C++ or Cocoa-based graphics APIs.

VectorMath also provides a  handy replacement for the GLKit vector math types and functions, which are not available yet in Swift due to their reliance on union types.

VectorMath is a completely standalone library, relying only on the Foundation framework. However, it provides optional compatibility exensions for SceneKit and Quartz (CoreGraphics/CoreAnimation) for easy interoperability with UIKit, AppKit, SpriteKit and SceneKit.

VectorMath is designed to be efficient, but has not been heavily optimized yet, and does not yet take advantage of architecture-specific hardware acceleration using the Accelerate framework.
 
 
Aknowledgements
----------------

Many of the algorithms used in VectorMath were ported or adapted from the Kazmath vector math library for C (https://github.com/Kazade/kazmath), or derived from the awesome Matrix and Quaternion FAQ (http://www.j3d.org/matrix_faq/matrfaq_latest.html).
 

Supported OS & SDK Versions
-----------------------------

* Supported build target - iOS 10.0, Mac OS 10.11 (Xcode 8.0, Apple LLVM compiler 8.0)
* Earliest supported deployment target - iOS 8.0, Mac OS 10.10
* Earliest compatible deployment target - iOS 7.0, Mac OS 10.9

NOTE: 'Supported' means that the library has been tested with this version. 'Compatible' means that the library should work on this OS version (i.e. it doesn't rely on any unavailable SDK features) but is no longer being tested for compatibility and may require tweaking or bug fixes to run correctly.


Installation
--------------

To use the VectorMath functions in an app, just drag the VectorMath.swift file (demo/test files and assets are not needed) into your project. You may also wish to include the VectorMath+SceneKit.swift and/or VectorMath+Quartz.swift compatibility extensions.


Types
--------------

VectorMath declares the following types:

    Scalar

This is a typealias used for the scalar floating point values in the VectorMath library. It is set to Float by default, but you can change it to Double or CGFloat to improve performance for your specific application.

    Vector2
    Vector3
    Vector4

These represent 2D, 3D and 4D vectors, respectively.

    Matrix3
    Matrix4

These represent homogenous 3x3 and 4x4 transform matrices, respectively.

    Quaternion

This represents a rotation in 3D space. It has the same structure as Vector4D, but is defined as a different type due to the different use cases and methods.
 
All the VectorMath types conform to Equatable and Hashable, so they can be stored in Swift dictionaries.


Constants
-------------

VectorMath declares a number of namespaced constants for your convenience. They are as follows:

    Scalar.pi
    Scalar.halfPi
    Scalar.quarterPi
    Scalar.twoPi

These should be self-explanatory.

    Scalar.degreesPerRadian
    Scalar.radiansPerDegree

Conversion factors between degrees and radians. E.g. to convert 40 degrees to radians, you would say `let r = 40 * .degreesPerRadian`, or to convert Pi/2 radians to degrees, say `let d = .halfPi * .radiansPerDegree`

    Scalar.epsilon = 0.0001

This is a floating point error value used by the approx-equal operator. You can change this if it's insufficiently (or excessively) precise for your needs.

    Vector2.zero
    Vector3.zero
    Vector4.zero
    Quaternion.Zero

These are zero vector constants, useful as default values for vectors

    Vector2.x
    Vector2.y
    Vector3.x
    Vector3.y
    Vector3.z
    Vector4.x
    Vector4.y
    Vector4.z
    Vector4.w

These are unit vectors along various axes. For example Vector3.z has the value `Vector3(0, 0, 1)`

    Matrix3.identity
    Matrix4.identity
    Quaternion.identity

These are identity matrices, which have the property that multiplying them by another matrix or vector has no effect.


Methods
------------

The complete list of VectorMath properties and methods is given below. These are mostly self-explanatory. If you can't find a method you are looking for (e.g. a method to rotate a vector using a quaternion), it's probably implemented as an operator (see "Operators" below).

    Vector2
        init(x: Scalar, y: Scalar)
        init(_: Scalar, _: Scalar)
        init(_: [Scalar])
        lengthSquared: Scalar
        length: Scalar
        inverse: Vector2
        toArray() -> [Scalar]
        dot(Vector2) -> Scalar
        cross(Vector2) -> Scalar
        normalized() -> Vector2
        rotated(by: Scalar) -> Vector2
        rotated(by: Scalar, around: Vector2) -> Vector2
        angleW(with: Vector2) -> Scalar
        interpolatedWith(Vector2, t: Scalar) -> Vector2

    Vector3
        init(x: Scalar, y: Scalar, z: Scalar)
        init(_: Scalar, _: Scalar, _: Scalar)
        init(_: [Scalar])
        lengthSquared: Scalar
        length: Scalar
        inverse: Vector3
        xy: Vector2
        xz: Vector2
        yz: Vector2
        toArray() -> [Scalar]
        dot(Vector3) -> Scalar
        cross(Vector3) -> Vector3
        normalized() -> Vector3
        interpolated(with: Vector3, by: Scalar) -> Vector3

    Vector4
        init(x: Scalar, y: Scalar, z: Scalar, w: Scalar)
        init(_: Scalar, _: Scalar, _: Scalar, _: Scalar)
        init(_: Vector3, w: Scalar)
        init(_: [Scalar])
        lengthSquared: Scalar
        length: Scalar
        inverse: Vector4
        xyz: Vector3
        xy: Vector2
        xz: Vector2
        yz: Vector2
        toArray() -> [Scalar]
        toVector3() -> Vector3
        dot(Vector4) -> Scalar
        normalized() -> Vector4
        interpolated(with: Vector4, by: Scalar) -> Vector4

    Matrix3
        init(m11: Scalar, m12: Scalar, ... m33: Scalar)
        init(_: Scalar, _: Scalar, ... _: Scalar)
        init(scale: Vector2)
        init(translation: Vector2)
        init(rotation: Scalar)
        init(_: [Scalar])
        adjugate: Matrix3
        determinant: Scalar
        transpose: Matrix3
        inverse: Matrix3
        toArray() -> [Scalar]
        interpolated(with: Matrix3, by: Scalar) -> Matrix3

    Matrix4
        init(m11: Scalar, m12: Scalar, ... m33: Scalar)
        init(_: Scalar, _: Scalar, ... _: Scalar)
        init(scale: Vector3)
        init(translation: Vector3)
        init(rotation: Vector4)
        init(quaternion: Quaternion)
        init(fovx: Scalar, fovy: Scalar, near: Scalar, far: Scalar)
        init(fovx: Scalar, aspect: Scalar, near: Scalar, far: Scalar)
        init(fovy: Scalar, aspect: Scalar, near: Scalar, far: Scalar)
        init(top: Scalar, right: Scalar, bottom: Scalar, left: Scalar, near: Scalar, far: Scalar)
        init(_: [Scalar])
        adjugate: Matrix4
        determinant: Scalar
        transpose: Matrix4
        inverse: Matrix4
        toArray() -> [Scalar]
        interpolated(with: Matrix3, by: Scalar) -> Matrix3

    Quaternion
        init(x: Scalar, y: Scalar, z: Scalar, w: Scalar)
        init(_: Scalar, _: Scalar, _: Scalar, _: Scalar)
        init(axisAngle: Vector4)
        init(pitch: Scalar, yaw: Scalar, roll: Scalar)
        init(rotationMatrix m: Matrix4)
        init(_: [Scalar])
        lengthSquared: Scalar
        length: Scalar
        inverse: Quaternion
        xyz: Vector3
        pitch: Scalar
        yaw: Scalar
        roll: Scalar
        toAxisAngle() -> Vector4
        toPitchYawRoll() -> (pitch: Scalar, yaw: Scalar, roll: Scalar)
        toArray() -> [Scalar]
        dot(Quaternion) -> Scalar
        normalized() -> Quaternion
        interpolated(with: Quaternion, by: Scalar) -> Quaternion


Operators
------------

VectorMath makes extensive use of operator overloading, but I've tried not to go overboard with crazy custom operators. The only nonstandard operator defined is `~=`, meaning "approximately equal", which is extremely useful for comparing Scalar, Vector or Matrix values for equality, as, due to floating point imprecision, they are rarely identical.

The *, /, +, - and == operators are implemented for most of the included types. * in particular is useful for matrix and vector transforms. For example, to apply a matrix transform "m" to a vector "v" you can just write `m * v`. * can also be used in conjunction with a Scalar value to scale a vector.

Unary minus is supported for inversion/negation on vectors and matrices.

Dot product, cross product and normalization are not available in operator form, but are supplied as methods on the various types.


Release notes
----------------

Version 0.3

- Updated for Swift 3
- Added `init(_: Vector3, w: Scalar)` and `toVector3() -> Vector3` methods to Vector4
- Renamed some methods and properties in accordance with modern conventions

Version 0.2
 
- Added Mac support
- Fixed Vector4, Matrix4 multiplication bug
- Fixed bug in `Quaternion(pitch:, yaw:, roll:)` initializer
 
Version 0.1

- First release
