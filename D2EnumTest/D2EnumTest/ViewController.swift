//
//  ViewController.swift
//  D2EnumTest
//
//  Created by Nabeel Ahamed on 7/13/21.
//

import UIKit

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

class ViewController: UIViewController {

    func takeIntReturnCode(input: Int) throws -> NumCode {
        
        guard input < 4 else {
            throw NumError.tooBig
        }
        
        guard let returnValue = NumCode.init(rawValue: input) else {
            throw NumError.others
        }
        
        return returnValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print (try? takeIntReturnCode(input: 1))
        print (try? takeIntReturnCode(input: 3))
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

    }


}

