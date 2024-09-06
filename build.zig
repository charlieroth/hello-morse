const std = @import("std");
const MicroZig = @import("microzig/build");
const rp2040 = @import("microzig/bsp/raspberrypi/rp2040");

pub fn build(b: *std.Build) void {
    const mz = MicroZig.init(b, .{});
    const optimize = b.standardOptimizeOption(.{});

    // Works like addExecutable, but takes a `microzig.Target`
    // for target instead of a `std.zig.CrossTarget`
    //
    // Target conveys all necessary information on the chip,
    // cpu and potentially the board as well
    const firmware = mz.add_firmware(b, .{ .name = "hello-morse", .target = rp2040.boards.raspberrypi.pico, .optimize = optimize, .root_source_file = b.path("src/main.zig") });

    // `install_firmware()` is a MicroZig pendant to `Build.installArtifact()`
    // and allows installing the firmware as a typical firmware file.
    //
    // Will also install to `$prefix/firmware` instead of `$prefix/bin`
    mz.install_firmware(b, firmware, .{});

    // For debugging, will also install the firmware as an ELF file
    mz.install_firmware(b, firmware, .{ .format = .elf });
}
