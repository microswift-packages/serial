import HAL

public extension Usart {
    static func setupSerial(baudRate: UInt32 = 57_600, cpuRate: UInt32 = 16_000_000) {
        guard baudRate > 1 else { return }
        let ubrrCalculated = cpuRate / (16 * (baudRate - 1))
        ubrr.registerValue = UInt16(ubrrCalculated)
        ucsrc.registerValue = (1<<UCSZ01)|(1<<UCSZ00)
        ucsrb.registerValue = (1<<RXEN0)|(1<<TXEN0)
    }

    static func readyForTx() -> Bool {
        ucsra & (1<<5) > 0
    }

    @discardableResult
    static func write(_ byte: UInt8, timeout: UInt16 = 0) -> Bool {
        var remainingTimeout = timeout
        while !readyForTx() {
            if timeout > 0 {
                remainingTimeout -= 1
                if remainingTimeout == 0 {
                    return false
                }
            }
        }
    
        udr = byte
        return true
    }
    
    static func write(_ string: StaticString, timeout: UInt16 = 0) {
        for byte in string {
            write(byte, timeout: timeout)
        }
    }
}
