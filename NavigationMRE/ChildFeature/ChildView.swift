//
//  ChildView.swift
//  NavigationMRE
//
//  Created by Daniels Liekmanis on 12/02/2024.
//

import ComposableArchitecture
import SwiftUI

struct ChildView: View {
    @Perception.Bindable var store: StoreOf<ChildFeature>

    var body: some View {
        Text("Child Feature")
    }
}

#Preview {
    ChildView(
        store: Store(
            initialState: ChildFeature.State()
        ) {
            ChildFeature()
        }
    )
}
