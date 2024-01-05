//
//  RealTimeTokenizerView.swift
//  L10nTokenizer
//
//  Created by George Kaimakas on 5/1/24.
//

import ComposableArchitecture
import Foundation
import SwiftUI
import UIKit

public struct RealTimeTokenizerView: View {
    @Bindable var store: StoreOf<RealTimeTokenizer>
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                Text(store.input)
                    .font(.largeTitle)
                    .multilineTextAlignment(.leading)
                    .textInputAutocapitalization(.never)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(store.tokens, id: \.self) { token in
                        Text(token)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        .padding()
        .safeAreaInset(edge: .bottom) {
            VStack(alignment: .leading, spacing: 8) {
                TextField(LocalizedStringKey("input"), text: $store.input)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
        }
    }
    
    public init(_ store: StoreOf<RealTimeTokenizer>) {
        self.store = store
    }
    
    public init() {
        self.store = .init(initialState: .init()) {
            RealTimeTokenizer()
        }
    }
}

#Preview {
    RealTimeTokenizerView()
}

public class RealTimeTokenizerViewController: UIHostingController<RealTimeTokenizerView> {
    @MainActor
    public init(_ store: StoreOf<RealTimeTokenizer>) {
        super.init(rootView: .init(store))
    }
    
    @MainActor 
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
