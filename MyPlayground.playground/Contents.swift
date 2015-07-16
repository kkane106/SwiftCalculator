var x : [AnyObject] = [1.0, +, 2.0, -, 4.0]
for i in 0...(x.count-1) {
    var solution : Double = 0
    if i % 2 != 0 {
        
    } else {
        var current = i, next = i+1, afterNext = i+2
        solution = solution + x[next](x[current], x[afterNext])
    }
}