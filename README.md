# serial

`func setupSerial(baudRate: UInt32 = 57_600, cpuRate: UInt32 = 16_000_000)`
start the serial port rx and tx with a specified baud rate

`func write(_ byte: UInt8, timeout: UInt16 = 0) -> Bool`
write a single byte to the uart

`func write(_ string: StaticString, timeout: UInt16 = 0)`
write a fixed constant string to the uart
