//
//  BluetoothStatusSection.swift
//  can9
//
//  Created by Nikunj Rathod on 2025-07-09.
//


import SwiftUI

struct BluetoothStatusSection: View {
    @ObservedObject var bluetoothManager: BluetoothManager

    var body: some View {
        VStack(spacing: 20) {
            Text("🔵 Bluetooth Status")
                .font(.title2)
                .bold()

            Text(bluetoothManager.isBluetoothAvailable ? "Available ✅" : "Unavailable ❌")
                .foregroundColor(bluetoothManager.isBluetoothAvailable ? .green : .red)
                .font(.headline)

            if bluetoothManager.isBluetoothAvailable {
                List(bluetoothManager.discoveredDevices, id: \.identifier) { peripheral in
                    VStack(alignment: .leading) {
                        Text(peripheral.name ?? "Unknown Device")
                            .font(.headline)
                        Text(peripheral.identifier.uuidString)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .listStyle(.plain)
                .frame(maxHeight: 300)
            } else {
                Text("Make sure Bluetooth is turned on in Settings.")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
    }
}
