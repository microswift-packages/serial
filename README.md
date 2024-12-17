# serial

`func setupSerial(baudRate: UInt32 = 57_600, cpuRate: UInt32 = 16_000_000)`
start the serial port rx and tx with a specified baud rate

`func write(_ byte: UInt8, timeout: UInt16 = 0) -> Bool`
write a single byte to the uart

`func write(_ string: StaticString, timeout: UInt16 = 0)`
write a fixed constant string to the uart


Here's a simple hello world example...

```
import ATmega328P
import serial

ATmega328P.Usart0.setupSerial()

// efficiently write the bytes from a constant stored in flash memory to a Usart
// note, this doesn't include a newline automatically
ATmega328P.Usart0.write("Hello: World")
// write a single byte to a Usart, for example here a newline
ATmega328P.Usart0.write(10)
// write a single byte to a Usart, for example here a CR
// adding an optional timeout to prevent hanging
ATmega328P.Usart0.write(13, timeout: 200_000)
```