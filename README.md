<p align="center">
    <img src="assets/consoleIO_logo.png" width="1000" max-width="75%" alt=“ConsoleIO” />
</p>

<p align="center">
    <a href="https://travis-ci.org/wendyliga/ConsoleIO">
        <img src="https://travis-ci.org/wendyliga/ConsoleIO.svg?branch=master" alt="BuddyBuild" />
    </a> 
    <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
    </a>
    <a href="https://twitter.com/wendyliga">
        <img src="https://img.shields.io/badge/contact-@wendyliga-blue.svg?style=flat" alt="Twitter: @wendyliga" />
    </a>
</p>


Swift Console Helper for Input and Output

## Installation
Using the Swift Package Manager

To install ConsoleIO for use in a Swift Package Manager-powered tool, add ConsoleIO as a dependency to your Package.swift file. For more information, please see the Swift Package Manager documentation.

```
.package(url: "https://github.com/wendyliga/ConsoleIO.git", from: "1.0.0")
```

## How to Use
### Input
#### Without Default Value

```swift
import ConsoleIO

let userInputResult = input(message, validator: { result -> Bool in
            let target = result.lowercased()
            
            guard target == "y" || target == "n" else {
                return false
            }
            
            return true
        }, failedToValidate: () -> Void = {
            print("Please select yes(y) or no(n) only")
        })
```

with:
- Message: text you want to show to console
- validator: your rules that determine is current result is what you wish your user input or not
- failedToValidate: any action you want to do after failed to validation

`Note: if user failed to satisfied validator with what user inputted, the ConsoleIO will automatically ask the question again, until validator is satisfied, if you want to put some default value, check another example below.` 

#### With Default Value
Asking for input with default value

```swift
import ConsoleIO

let message = "Input your username? you can leave it empty(will use Jhon Doe)" 
let defaultUserName = "Jhon Doe"

let validator: (String) -> Bool = { result -> Bool in
    return result.count < 50
}

let checkValidationResult: (String, Bool) -> Void = { result, isValid in
    if !isValid {
        print("\(result) doesn't valid, please try again")
    }
}

let afterValidation: (String) -> Void = { result in
    if result == defaultDirectory {
        print("You will use \(defaultDirectory)")
    }
}

let username = input(message, 
                     defaultValue: defaultUserName, 
                     validator: validator, 
                     checkValidationResult: checkValidationResult, 
                     afterValidation: afterValidation)
```

with:
- message: text you want to show to console
- defaultValue: default value if user input empty/just enter on console
- validator: your rules that determine is current result is what you wish your user input or not
- checkValidationResult: any action you want to do after `ConsoleIO` check the validation but before next action is being executed.
- afterValidation: any action you want to execute after valid validation and before return

### Output

You can output to console with preset

There's Several mode:
  - normal
  - error
  - warning

Example:
```swift
  output("Please enter only valid number", to: .error)
```
or
```swift
  output("Your session was invalid, please login again", to: .error, prefix: "❌", thenExit: true)
```

several things you can utilize:
- prefix: any string you want to put on prefix of the message
- to: determine the styling atau status of the output
- theExit: if you want to exit the application after outputing the message

## License

ConsoleIO

Copyright (c) 2020 Wendy Liga. Licensed under the MIT license, as follows:

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
