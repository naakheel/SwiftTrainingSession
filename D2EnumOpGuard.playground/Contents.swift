import UIKit

var greeting = "Hello, playground"

enum NumError : Error {
    case tooSmall
    case tooBig
    case others
}

enum NumCode : Int {
    case zero
    case one
    case two
    case three
}

func takeIntReturnCode(input: Int) throws -> NumCode {
    
    guard input < 4 else {
        throw NumError.tooBig
    }
    
    guard let returnValue = NumCode.init(rawValue: input) else {
        throw NumError.others
    }
    
    return returnValue
}

print (try takeIntReturnCode(input: 1))
print (try takeIntReturnCode(input: 3))
do {
   try print (takeIntReturnCode(input: -1))
} catch {
    print (error)
}
do {
  try print (takeIntReturnCode(input: 4))
} catch {
    print (error)
}
