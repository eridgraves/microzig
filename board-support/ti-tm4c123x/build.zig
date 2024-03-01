const std = @import("std");
const MicroZig = @import("microzig-build");

pub const microzig_board_support = MicroZig.registerBoardSupport(@This());

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".");
}
const build_root = root();

const KiB = 1024;

////////////////////////////////////////
//      MicroZig Gen 2 Interface      //
////////////////////////////////////////

pub fn build(b: *std.Build) !void {
    _ = b;
    //  Dummy func to make package manager happy
}

pub const chips = struct {
    pub const tm4c123x = MicroZig.Target{
        .preferred_format = .elf,
        .chip = .{
            .name = "TM4C123X",
            .cpu = .cortex_m4, // TODO: TM4C123GXL is "ARM® Cortex®-M4F". Document which functionality we lose (if any)
            .memory_regions = &.{
                .{ .offset = 0x00000000, .length = 40 * KiB, .kind = .flash },
                .{ .offset = 0x20000000, .length = 8 * KiB, .kind = .ram },
            },
            .register_definition = .{
                .json = .{ .cwd_relative = build_root ++ "/src/chips/TM4C123X.json" }, // TODO file
            },
        },
        .hal = .{
            .source_file = .{ .cwd_relative = build_root ++ "/src/hals/TM4C123X/hal.zig" }, // TODO file
        },
    };

    // TODO TM4C129X: Add support for TM4C123X starting here
    // pub const stm32f303vc = MicroZig.Target{
    //     .preferred_format = .elf,
    //     .chip = .{
    //         .name = "STM32F303",
    //         .cpu = .cortex_m4,
    //         .memory_regions = &.{
    //             .{ .offset = 0x08000000, .length = 256 * KiB, .kind = .flash },
    //             .{ .offset = 0x20000000, .length = 40 * KiB, .kind = .ram },
    //         },
    //         .register_definition = .{
    //             .json = .{ .cwd_relative = build_root ++ "/src/chips/STM32F303.json" },
    //         },
    //     },
    // };

    // TODO TM4C129X: add support per cpu? see https://www.ti.com/lit/an/spma065/spma065.pdf?ts=1709125102720
    // These differ a lot more (i.e. ethernet!!, CPU frequency, hybernation modes ...) than the STM parts I am following as a template (below)...

    // // All STM32L0x1 series MCUs differ only in memory size. So we create a comptime function
    // // to generate all MCU variants as per https://www.st.com/en/microcontrollers-microprocessors/stm32l0x1.html
    // fn stm32l0x1(comptime rom_size: u64, comptime ram_size: u64) MicroZig.Target {
    //     return MicroZig.Target{
    //         .preferred_format = .elf,
    //         .chip = .{
    //             .name = "STM32L0x1",
    //             .cpu = .cortex_m0plus,
    //             .memory_regions = &.{
    //                 .{ .offset = 0x08000000, .length = rom_size, .kind = .flash },
    //                 .{ .offset = 0x20000000, .length = ram_size, .kind = .ram },
    //             },
    //             .register_definition = .{
    //                 .svd = .{ .cwd_relative = build_root ++ "/src/chips/STM32L0x1.svd" },
    //             },
    //         },
    //     };
    // }

    // pub const stm32l011x3 = stm32l0x1(8 * KiB, 2 * KiB);

    // pub const stm32l011x4 = stm32l0x1(16 * KiB, 2 * KiB);
    // pub const stm32l021x4 = stm32l0x1(16 * KiB, 2 * KiB);
    // pub const stm32l031x4 = stm32l0x1(16 * KiB, 8 * KiB);

    // pub const stm32l031x6 = stm32l0x1(32 * KiB, 8 * KiB);
    // pub const stm32l041x6 = stm32l0x1(32 * KiB, 8 * KiB);
    // pub const stm32l051x6 = stm32l0x1(32 * KiB, 8 * KiB);

    // pub const stm32l051x8 = stm32l0x1(64 * KiB, 8 * KiB);
    // pub const stm32l071x8 = stm32l0x1(64 * KiB, 20 * KiB);

    // pub const stm32l071xb = stm32l0x1(128 * KiB, 20 * KiB);
    // pub const stm32l081cb = stm32l0x1(128 * KiB, 20 * KiB);

    // pub const stm32l071xz = stm32l0x1(192 * KiB, 20 * KiB);
    // pub const stm32l081xz = stm32l0x1(192 * KiB, 20 * KiB);

};

pub const boards = struct {
    pub const tm4c123xeval = MicroZig.Target{
        .preferred_format = .elf,
        .chip = chips.tm4c123x.chip,
        .board = .{
            .name = "TM4C123XEVAL",
            .source_file = .{ .path = build_root ++ "/src/boards/TM4C123XEVAL.zig" }, // TODO file
        },
    };

    // TODO TM4C129X: add eval
};
