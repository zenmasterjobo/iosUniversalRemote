import CoreBluetooth

protocol SimpleBluetoothIODelegate: class {
    func simpleBluetoothIO(simpleBluetoothIO: SimpleBluetoothIO, didReceiveValue value: UInt32)
}


class SimpleBluetoothIO: NSObject {
    let serviceUUID: String
    weak var delegate: SimpleBluetoothIODelegate?

    var centralManager: CBCentralManager!
    var connectedPeripheral: CBPeripheral?
    var targetService: CBService?
    var writableCharacteristic: CBCharacteristic?
    var writeCodeValueCharacteristic: CBCharacteristic?
    var writeCodeTypeCharacteristic: CBCharacteristic?
    var writeCodeBitCharacteristic: CBCharacteristic?

    init(serviceUUID: String, delegate: SimpleBluetoothIODelegate?) {
        self.serviceUUID = serviceUUID
        self.delegate = delegate

        super.init()

        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func writeValue(codeValue: UInt32, typeValue: UInt32, bitValue: UInt32) {
        guard let peripheral = connectedPeripheral, let codeCharacteristic = writeCodeValueCharacteristic, let typeCharacteristic = writeCodeTypeCharacteristic, let bitCharacteristic = writeCodeBitCharacteristic else {
            return
        }

        let Code = Data.dataWithValue(value: codeValue)
        let Type = Data.dataWithValue(value: typeValue)
        let Bit = Data.dataWithValue(value: bitValue)
        peripheral.writeValue(Code, for: codeCharacteristic, type: .withResponse)
        peripheral.writeValue(Type, for: typeCharacteristic, type: .withResponse)
        peripheral.writeValue(Bit, for: bitCharacteristic, type: .withResponse)

    }

}

extension SimpleBluetoothIO: CBCentralManagerDelegate {
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices(nil)
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        connectedPeripheral = peripheral

        if let connectedPeripheral = connectedPeripheral {
            connectedPeripheral.delegate = self
            centralManager.connect(connectedPeripheral, options: nil)
        }
        centralManager.stopScan()
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: [CBUUID(string: serviceUUID)], options: nil)
        }
    }
}

extension SimpleBluetoothIO: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {
            return
        }

        targetService = services.first
        if let service = services.first {
            targetService = service
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {
            return
        }

        for characteristic in characteristics {
            if characteristic.properties.contains(.write) || characteristic.properties.contains(.writeWithoutResponse) {
                if characteristic.uuid == CBUUID(string: "19B10011-E8F2-537E-4F6C-D104768A1214") {
                    print("Found writeValueCharacteristic")
                    writeCodeValueCharacteristic = characteristic
                } else if characteristic.uuid == CBUUID(string: "19B10013-E8F2-537E-4F6C-D104768A1214") {
                    print("Found writeTypeCharacteristic")
                    writeCodeTypeCharacteristic = characteristic
                } else if characteristic.uuid == CBUUID(string: "19B10014-E8F2-537E-4F6C-D104768A1214") {
                    print("Found writeBitCharacteristic")
                    writeCodeBitCharacteristic = characteristic
                }
            }
            peripheral.setNotifyValue(true, for: characteristic)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let data = characteristic.value, let delegate = delegate else {
                return
        }
        delegate.simpleBluetoothIO(simpleBluetoothIO: self, didReceiveValue: data.uInt32Value())
    }
 
}
