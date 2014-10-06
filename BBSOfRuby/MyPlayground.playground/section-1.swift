// Playground - noun: a place where people can play

import UIKit

var a = 10, b = 20
func swapValue<T>(inout a: T,inout b: T) {
    let temp = b
    b = a
    a = temp
}
swapValue(&a, &b)
println(a)
println(b)