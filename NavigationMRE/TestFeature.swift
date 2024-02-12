//
//  TestFeature.swift
//  NavigationMRE
//
//  Created by Daniels Liekmanis on 12/02/2024.
//

import ComposableArchitecture

@Reducer
struct TestFeature {
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
    }

    enum Action: Equatable {
        case linkTapped

        case destination(PresentationAction<Destination.Action>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .linkTapped:
                    state.destination = .childFeature(.init())
                    return .none

                case .destination:
                    return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
    }

    @Reducer
    public struct Destination {
        @ObservableState
        @CasePathable
        public enum State: Equatable {
            case childFeature(ChildFeature.State)
        }

        public enum Action: Equatable {
            case childFeature(ChildFeature.Action)
        }

        public var body: some ReducerOf<Self> {
            Scope(
                state: \.childFeature,
                action: \.childFeature
            ) {
                ChildFeature()
            }
        }
    }
}
