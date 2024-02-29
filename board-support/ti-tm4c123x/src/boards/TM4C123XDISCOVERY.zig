pub const micro = @import("microzig");

pub const cpu_frequency = 80_000_000; // 80 MHz

pub const pin_map = .{

    // TODO: untested pinouts for LEDs. From https://www.ti.com/lit/ug/spmu296/spmu296.pdf?ts=1709155496565
    // TODO: check left sides of assignments.
    // red
    .LD4 = "PF1",
    // blue
    .LD5 = "PF2",
    // green
    .LD6 = "PF3",
};

// TODO: add UART, SPI, I2C, CAN, USB 2.0 (or any subset of this list)
// pub fn debug_write(string: []const u8) void {
//     const uart1 = micro.core.experimental.Uart(1, .{}).get_or_init(.{
//         .baud_rate = 9600,
//         .data_bits = .eight,
//         .parity = null,
//         .stop_bits = .one,
//     }) catch unreachable;

//     const writer = uart1.writer();
//     _ = writer.write(string) catch unreachable;
//     uart1.internal.txflush();
// }
