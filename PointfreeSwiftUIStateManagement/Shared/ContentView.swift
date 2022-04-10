//
//  ContentView.swift
//  Shared
//
//  Created by Sergey Borovkov on 10.04.2022.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var state: AppState

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: EmptyView(),
                               label: {
                    Text("Favorites numbers")
                })

                NavigationLink(destination: CounterView(state: state),
                               label: {
                    Text("Count the number")
                })
            }
            .navigationTitle("Favorites actions")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

class AppState: ObservableObject {
    @Published var count: Int = 0
    @Published var favoritesPrimes: [Int] = []
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(state: AppState())
    }
}
