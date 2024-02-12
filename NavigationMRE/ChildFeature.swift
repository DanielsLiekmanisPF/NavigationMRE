//
//  ChildFeature.swift
//  NavigationMRE
//
//  Created by Daniels Liekmanis on 12/02/2024.
//

import ComposableArchitecture

@Reducer
struct ChildFeature {
    @ObservableState
    struct State: Equatable {}

    enum Action: Equatable {}

    var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {}
        }
    }
}
