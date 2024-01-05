//
//  L10nTokenizer.swift
//  L10nTokenizer
//
//  Created by George Kaimakas on 5/1/24.
//

import Foundation

@resultBuilder
struct LocalizableSeparatorBuilder {
    static func buildBlock(_ components: String...) -> [String] {
        components
    }
}

public struct L10nTokenizer {
    let separators: [String]
    let regex: Regex<AnyRegexOutput>
    
    public init(
        @LocalizableSeparatorBuilder seperators keys: () -> [String]
    ) {
        self.separators = keys()
        
        let rawCaptures = separators
            .map { "\\b\($0)\\b" }
            .joined(separator: "|")
        self.regex = try! Regex(rawCaptures)
        
    }
    
    public func tokenize(
        _ input: String,
        includeToken: Bool = false
    ) -> [String] {
        guard separators.isEmpty == false else { return [] }
        
        switch includeToken {
        case true:
            var inputCopy = input
            let tokens = input
                .split(separator: regex)
                .map(String.init)
            var result: [String] = []
            
            for token in tokens {
                var sentence = ""
                if inputCopy.hasPrefix(token) { // is the start of the string
                    sentence = token
                } else {
                    if let range = inputCopy.range(of: token) {
                        let possibleSeparator = inputCopy[..<range.lowerBound]
                        sentence = String(possibleSeparator) + token
                    }
                }
                
                result.append(sentence)
                inputCopy = String(inputCopy.dropFirst(sentence.count))
                
            }
            
            return result
            
        case false:
            return input
                .split(separator: regex)
                .map(String.init)
        }
    }
}
