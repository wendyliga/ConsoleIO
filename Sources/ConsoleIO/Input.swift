/**
 *  ConsoleIO
 *
 *  Copyright (c) 2020 Wendy Liga. Licensed under the MIT license, as follows:
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */

import Foundation
import SwiftKit

/**
 Retreive Input from user
 
 - Parameters:
    - message: message to show to user
    - defaultValue: value that defaultly apply if user don't input anything
    - validator: closure that will return `Bool`, that let's user determine is value is already valid or not
    - checkValidationResult: any execution you want to execute after validator executing its task and before next action is being executed, `T` for the result user input and `Bool` for validation result
    - afterValidation: execute action after validation finish, will bring `T` value
 - Returns: will return `T`
 
 Example:
    ```
    let result = input("number of random?", defaultValue: 0) { userInputResult in
        return userInputResult < 100
    }
    ```
 */
@discardableResult
public func input<T>(_ message: String, defaultValue: T, validator: ((T) -> Bool)? = nil, checkValidationResult: ((_ result: T,_ validationResult: Bool) -> Void)? = nil, afterValidation: ((T) -> Void)? = nil) -> T {
    // output message
    output(message)
    
    // result value safe here
    var result: T
    
    if let userInput = readLine()?.nonEmpty as? T {
        let validationResult = validator?(userInput) ?? true
        
        // execute action after validation
        checkValidationResult?(userInput, validationResult)
        
        // check validation result
        guard validationResult else {
            // retry if false
            return ConsoleIO.input(message, defaultValue: defaultValue, validator: validator, checkValidationResult: checkValidationResult)
        }
        
        // save user input as result
        result = userInput
    } else {
        // use default value
        result = defaultValue
    }
    
    // execute after validation action
    defer {
        afterValidation?(result)
    }
    
    // return value
    return result
}

/**
Retreive Input from user without default value, so user need to input until its satisfied the validator

 - Parameters:
    - message: message to show to user
    - validator: closure that will return `Bool`, that let's user determine is value is already valid or not
    - failedToValidate: any execution you want to execute after validator resulting failed

- Returns: will return `T`

Example:
   ```
   let result = input("number of random?") { userInputResult in
       return userInputResult < 5
   }
   ```
*/
@discardableResult
public func input<T>(_ message: String, validator: (T) -> Bool, failedToValidate executeFailedValidationAction: (() -> Void)?) -> T {
    // output message
    output(message)
    
    guard let result = readLine()?.nonEmpty as? T, validator(result) else {
        // execute action after validation
        executeFailedValidationAction?()
        
        return ConsoleIO.input(message, validator: validator, failedToValidate: executeFailedValidationAction)
    }
    
    return result
}

