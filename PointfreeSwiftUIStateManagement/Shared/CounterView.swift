import SwiftUI

struct CounterView: View {

    @ObservedObject var state: AppState
    @State var isPrimeModalShown: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: { self.state.count -= 1},
                           label: { Text("-") })

                    Text("\(state.count)")

                    Button(action: { self.state.count += 1},
                           label: { Text("+") })
                }

                Button(action: { self.isPrimeModalShown.toggle() },
                       label: {
                    Text("Is the \(self.state.count) prime?")
                })

                Button(action: { },
                       label: {
                    Text("What's the \(self.state.count) prime?")
                })
            }
            .sheet(
                isPresented: $isPrimeModalShown,
                content: { PrimeModalView(state: state) }
            )
            .navigationTitle("Prime view")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(state: AppState())
    }
}
