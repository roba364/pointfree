import SwiftUI

struct PrimeModalView: View {

    @ObservedObject var state: AppState

    var body: some View {
        VStack {
            if isPrime(number: state.count) {
                Text("Number \(self.state.count) is prime")
                if state.favoritesPrimes.contains(state.count) {
                    Button(action: { state.favoritesPrimes.removeAll(where: { $0 == state.count } )},
                           label: {
                        Text("remove from favorites primes")
                    })
                } else {
                    Button(action: { state.favoritesPrimes.append(state.count) },
                           label: {
                        Text("Save to favorites primes")
                    })
                }

            } else {
                Text("Number \(self.state.count) is not prime")
            }
        }

    }
}

func isPrime(number: Int) -> Bool {
    if number <= 1 { return false }
    if number <= 3 { return true }
    for i in 2...Int(sqrtf(Float(number))) {
        if number % i == 0 { return false }

    }
    return true
}

struct PrimeModalView_Previews: PreviewProvider {
    static var previews: some View {
        PrimeModalView(state: AppState())
    }
}
