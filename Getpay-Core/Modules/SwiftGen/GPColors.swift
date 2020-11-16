// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  public typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  public typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
public struct GPColors {
  public let rgbaValue: UInt32
  public var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f5f7fa"></span>
  /// Alpha: 100% <br/> (0xf5f7faff)
  public static let apu = GPColors(rgbaValue: 0xf5f7faff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#000000"></span>
  /// Alpha: 100% <br/> (0x000000ff)
  public static let barney = GPColors(rgbaValue: 0x000000ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fbd2d3"></span>
  /// Alpha: 100% <br/> (0xfbd2d3ff)
  public static let bart = GPColors(rgbaValue: 0xfbd2d3ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#87d883"></span>
  /// Alpha: 100% <br/> (0x87d883ff)
  public static let burns = GPColors(rgbaValue: 0x87d883ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#edf9ed"></span>
  /// Alpha: 100% <br/> (0xedf9edff)
  public static let duffman = GPColors(rgbaValue: 0xedf9edff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#222629"></span>
  /// Alpha: 100% <br/> (0x222629ff)
  public static let edna = GPColors(rgbaValue: 0x222629ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#66707a"></span>
  /// Alpha: 100% <br/> (0x66707aff)
  public static let flanders = GPColors(rgbaValue: 0x66707aff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#8996a3"></span>
  /// Alpha: 100% <br/> (0x8996a3ff)
  public static let heyman = GPColors(rgbaValue: 0x8996a3ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#de3131"></span>
  /// Alpha: 100% <br/> (0xde3131ff)
  public static let homer = GPColors(rgbaValue: 0xde3131ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#bcc4cc"></span>
  /// Alpha: 100% <br/> (0xbcc4ccff)
  public static let krusty = GPColors(rgbaValue: 0xbcc4ccff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fffbef"></span>
  /// Alpha: 100% <br/> (0xfffbefff)
  public static let lenny = GPColors(rgbaValue: 0xfffbefff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f58e92"></span>
  /// Alpha: 100% <br/> (0xf58e92ff)
  public static let lisa = GPColors(rgbaValue: 0xf58e92ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f27130"></span>
  /// Alpha: 100% <br/> (0xf27130ff)
  public static let luann = GPColors(rgbaValue: 0xf27130ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  public static let maggie = GPColors(rgbaValue: 0xffffffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f06166"></span>
  /// Alpha: 100% <br/> (0xf06166ff)
  public static let marge = GPColors(rgbaValue: 0xf06166ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffa64d"></span>
  /// Alpha: 100% <br/> (0xffa64dff)
  public static let milhouse = GPColors(rgbaValue: 0xffa64dff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e1e6eb"></span>
  /// Alpha: 100% <br/> (0xe1e6ebff)
  public static let moe = GPColors(rgbaValue: 0xe1e6ebff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#9aa9b8"></span>
  /// Alpha: 100% <br/> (0x9aa9b8ff)
  public static let nelson = GPColors(rgbaValue: 0x9aa9b8ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#454b52"></span>
  /// Alpha: 100% <br/> (0x454b52ff)
  public static let ralph = GPColors(rgbaValue: 0x454b52ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#7194ff"></span>
  /// Alpha: 100% <br/> (0x7194ffff)
  public static let rod = GPColors(rgbaValue: 0x7194ffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#3366ff"></span>
  /// Alpha: 100% <br/> (0x3366ffff)
  public static let todd = GPColors(rgbaValue: 0x3366ffff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let components = RGBAComponents(rgbaValue: rgbaValue).normalized
    self.init(red: components[0], green: components[1], blue: components[2], alpha: components[3])
  }
}

private struct RGBAComponents {
  let rgbaValue: UInt32

  private var shifts: [UInt32] {
    [
      rgbaValue >> 24, // red
      rgbaValue >> 16, // green
      rgbaValue >> 8,  // blue
      rgbaValue        // alpha
    ]
  }

  private var components: [CGFloat] {
    shifts.map {
      CGFloat($0 & 0xff)
    }
  }

  var normalized: [CGFloat] {
    components.map { $0 / 255.0 }
  }
}

public extension Color {
  convenience init(named color: GPColors) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
