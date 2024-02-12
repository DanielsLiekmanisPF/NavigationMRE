//
//  ContentView.swift
//  NavigationMRE
//
//  Created by Daniels Liekmanis on 12/02/2024.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    @Perception.Bindable var store: StoreOf<TestFeature>

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
        }
    }
}

#Preview {
    ContentView(
        store: Store(
            initialState: TestFeature.State()
        ) {
            TestFeature()
        }
    )
}
