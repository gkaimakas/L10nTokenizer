//
//  RealTimeTokenizer.swift
//  L10nTokenizer
//
//  Created by George Kaimakas on 5/1/24.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct RealTimeTokenizer {
    @ObservableState
    public struct State {
        
        var input: String
        var includeToken: Bool = true
        
        var tokens: [String] {
            tokenizer.tokenize(input, includeToken: true)
        }
        
        var tokenizer: L10nTokenizer
        
        init() {
            input = ""
            tokenizer = .init {
                String(localized: "if")
                String(localized: "and")
            }
        }
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce(core)
            ._printChanges()
    }
    
    public init() {}
    
    func core(into state: inout State, action: Action) -> Effect<Action> {
        return .none
    }
}
