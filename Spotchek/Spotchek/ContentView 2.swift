import SwiftUI

struct ContentView: View {
    @State private var currentOffset: CGFloat = 700
    @State private var dragOffset: CGFloat = 0
    
    @StateObject private var locationManager = LocationManager()
    @State private var hasRequestedAccess = false
    
    @StateObject private var bluetoothManager = BluetoothManager()
    
    let maxOffset: CGFloat = 700   // Fully hidden
    let midOffset: CGFloat = 400   // Partially shown
    let minOffset: CGFloat = 100   // Fully shown

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                
                BluetoothStatusSection(bluetoothManager: bluetoothManager)
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    NavigationLink(destination: VehicleMarketView()) {
                        Text(locationManager.isConnectedToGPS ? "Tap to Begin Scan" : "Connecting…")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(locationManager.isConnectedToGPS ? Color.blue : Color.orange)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                    .disabled(!locationManager.isConnectedToGPS) // Prevents tap until GPS is ready

                    
                    Spacer()
                    Spacer()
                }
                .padding(.top, 60)
                .task {
                    locationManager.requestLocationAccess()
                }
                
                BottomSheetView()
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .shadow(radius: 10)
                    .offset(y: currentOffset + dragOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                dragOffset = value.translation.height
                            }
                            .onEnded { value in
                                // Combine gesture with current position
                                let newOffset = currentOffset + value.translation.height
                                let closest = [minOffset, midOffset, maxOffset]
                                    .min(by: { abs($0 - newOffset) < abs($1 - newOffset) }) ?? midOffset
                                currentOffset = closest
                                dragOffset = 0
                            }
                    )
                    .animation(.spring(), value: currentOffset)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct BottomSheetView: View {
    @State private var viewModel = ListViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(spacing: 8) {
               
                HStack {
                    Spacer()
                    Capsule()
                        .frame(width: 40, height: 6)
                        .foregroundColor(.gray.opacity(0.6))
                    Spacer()
                }
            }
            .padding(.top, 12)
            .padding(.bottom, 8)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Scan History")
                    .font(.title)
                    .foregroundColor(.primary)
                    .padding(.leading, 16)
            }
            .padding(.top, 12)
            .padding(.bottom, 8)


            if viewModel.isLoading {
                ProgressView("Loading items...")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(viewModel.items) { item in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title)
                                .font(.headline)
                            Text(item.subtitle)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        Button(action: {
                            share(text: item.shareURL?.absoluteString ?? "")
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.blue)
                                .padding(8)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(.plain)

            }
        }
        .task {
            await viewModel.loadItems()
        }

    }
}

struct ScanView: View {
    var body: some View {
        VStack {
            Text("Scan in Progress…")
                .font(.title)
                .padding()
            // Add your scanning UI here
            Spacer()
        }
    }
}

func share(text: String) {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let rootViewController = windowScene.windows.first?.rootViewController else {
        return
    }

    let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
    rootViewController.present(activityVC, animated: true)
}

#Preview {
    ContentView()
}
