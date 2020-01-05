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

/**
 Output type that will determine the status code and prefix
 */
public enum OutputType {
    case error
    case standard
    case warning
    
    /**
     Status code that will correspond to exit code
     */
    public var statusCode: Int32 {
        switch self {
        case .error:
            return 0
        case .standard, .warning:
            return 1
        }
    }
    
    /**
     default prefix when outputing message
     */
    public var defaultPrefix: String? {
        switch self {
        case .error:
            return "🙅‍♂️"
        case .warning:
            return "⚠️"
        default:
            return nil
        }
    }
}

/**
 Output to console to user
 
 you can choose type of the output and exit or not after it.
 */
public func output(_ message: String, to type: OutputType = .standard, prefix: String? = nil, thenExit: Bool = false) {
    
    let defaultPrefix = prefix ?? type.defaultPrefix
    let outputMessage = defaultPrefix == nil ? message : "\(defaultPrefix!) \(message)"
    
    switch type {
    case .standard, .warning:
        print(outputMessage)
    case .error:
        fputs(outputMessage + "\n", stderr)
    }
    
    if thenExit{
        exit(type.statusCode)
    }
}
