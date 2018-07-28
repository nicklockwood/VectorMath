//
//  VectorMath+MapKit.swift
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

#if canImport(MapKit)

import MapKit

// MARK: MapKit extensions

public extension MKMapPoint {
    init(_ v: Vector2) {
        self.init(x: Double(v.x), y: Double(v.y))
    }
}

public extension MKMapSize {
    init(_ v: Vector2) {
        self.init(width: Double(v.x), height: Double(v.y))
    }
}

// MARK: VectorMath extensions

public extension Vector2 {
    init(_ v: MKMapPoint) {
        self.init(x: Scalar(v.x), y: Scalar(v.y))
    }

    init(_ v: MKMapSize) {
        self.init(x: Scalar(v.width), y: Scalar(v.height))
    }
}

#endif
