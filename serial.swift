import HAL

private let UCSZ01 = 2
private let UCSZ00 = 1
private let RXEN0 = 4
private let TXEN0 = 3
private let UDRE0 = 5

public extension Usart {
    /// initialise the Usart. Switch the RX/TX pins to Usart functions.
    static func setupSerial(baudRate: UInt32 = 57_600, cpuRate: UInt32 = 16_000_000) {
        guard baudRate > 1 else { return }
        let ubrrCalculated = cpuRate / (16 * (baudRate - 1))
        ubrr.registerValue = UInt16(ubrrCalculated)
        ucsrc.registerValue = (1<<UCSZ01)|(1<<UCSZ00)
        ucsrb.registerValue = (1<<RXEN0)|(1<<TXEN0)
    }

    /// Disable the Usart. Return the pins to normal function (disable RX/TX).
    static func disableSerial() {
        ucsrb.registerValue = 0
    }

    /// Low level function to check if the data register is ready immediately.
    static func readyForTx() -> Bool {
        ucsra & (1<<UDRE0) > 0
    }

    /// Write a raw byte to the Usart.
    /// Optionally pass a timeout parameter to prevent hanging if
    /// the Usart does not become available for some reason. Note:
    /// this timeout is in "cycles", which isn't a calibrated unit,
    /// but it's probably within an order of magnitude of a us.
    /// Returns true if the byte was written, false if it timed out.
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
    
    /// Write a static string (does not automatically include a newline).
    static func write(_ string: StaticString, timeout: UInt16 = 0) {
        for byte in string {
            write(byte, timeout: timeout)
        }
    }
}
