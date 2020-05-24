import Foundation

public class GPLogger {
    public static func log(_ info: String) {
        #if DEBUG
            print("#log \(info)")
        #endif
    }
}
