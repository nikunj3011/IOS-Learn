//
//  BluetoothManager.swift
//  can9
//
//  Created by Nikunj Rathod on 2025-07-09.
//


import Foundation
import CoreBluetooth
import SwiftUI
import Combine

class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    private var centralManager: CBCentralManager!
    
    @Published var isBluetoothAvailable: Bool = false
    @Published var discoveredDevices: [CBPeripheral] = []
    
    override init() {
        super.init()
        // Note: You can specify a queue here, but nil defaults to the main queue
        // for delegate callbacks, which is actually safer for simple SwiftUI apps.
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        // Ensure UI updates happen on the main thread
        DispatchQueue.main.async {
            switch central.state {
            case .poweredOn:
                self.isBluetoothAvailable = true
                // Scanning with 'nil' services finds everything,
                // but can be battery-intensive.
                self.centralManager.scanForPeripherals(withServices: nil, options: nil)
            case .poweredOff, .unauthorized, .unsupported:
                self.isBluetoothAvailable = false
                self.discoveredDevices.removeAll()
                self.centralManager.stopScan()
            default:
                self.isBluetoothAvailable = false
            }
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        
        DispatchQueue.main.async {
            // Check by identifier to avoid duplicate entries in your list
            if !self.discoveredDevices.contains(where: { $0.identifier == peripheral.identifier }) {
                self.discoveredDevices.append(peripheral)
                
                // Debugging: See what you found
                let name = peripheral.name ?? "Unknown Device"
                print("Discovered: \(name) at \(RSSI) dBm")
            }
        }
    }
}
