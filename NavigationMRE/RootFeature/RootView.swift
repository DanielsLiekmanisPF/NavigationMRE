//
//  RootView.swift
//  NavigationMRE
//
//  Created by Daniels Liekmanis on 12/02/2024.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {
    @Perception.Bindable var store: StoreOf<RootFeature>

    var body: some View {
        NavigationView {
            WithPerceptionTracking {
                List {
                    Button {
                        store.send(.linkTapped)
                    } label: {
                        HStack {
                            Text("Child feature")
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Image(systemName: "chevron.right")
                        }
                    }
                }
                .navigationTitle(Text("Navigation MRE"))
                .navigationBarTitleDisplayMode(.large)
                .background(navigationLinks)
            }
        }
    }

    @MainActor
    private var navigationLinks: some View {
        WithPerceptionTracking {
            NavigationLinkStore(
                store.scope(
                    state: \.$destination.childFeature,
                    action: \.destination.childFeature
                ),
                onTap: {},
                destination: ChildView.init(store:),
                label: EmptyView.init
            )

            // This is an example of NavigationLink
            // that produces no perception warnings
//            NavigationLink(
//                isActive: Binding<Bool>(
//                    get: {
//                        if case .childFeature = store.destination {
//                            return true
//                        }
//                        return false
//                    },
//                    set: {
//                        if !$0 {
//                            store.send(.destination(.dismiss))
//                        }
//                    }
//                ),
//                destination: {
//                    // A hack to understand if this resolves perception warnings
//                    if let store = $store.scope(
//                        state: \.destination?.childFeature,
//                        action: \.destination.childFeature
//                    ).wrappedValue {
//                        ChildView(store: store)
//                    }
//                },
//                label: EmptyView.init
//            )
        }
    }
}

#Preview {
    RootView(
        store: Store(
            initialState: RootFeature.State()
        ) {
            RootFeature()
        }
    )
}
