import UIKit
import SystemConfiguration.CaptiveNetwork

// MARK: - Class

public class GNFingerPrint {
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    public func getAddress() -> String {
        let wifiIP = getAddress(for: .wifi)
        if wifiIP.isNotEmpty {
            return wifiIP
        }
        return getAddress(for: .cellular)
    }
    
    public func getWiFiSsid() -> String? {
        var ssid: String?
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    break
                }
            }
        }
        return ssid
    }
}

extension GNFingerPrint {
    
    // MARK: - Private methods
    
    private func getAddress(for network: Network) -> String {
        var address = ""
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return "" }
        guard let firstAddr = ifaddr else { return "" }
        
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                let name = String(cString: interface.ifa_name)
                if name == network.rawValue {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        return address
    }
}

// MARK: - Enum

public enum Network: String {
    case wifi = "en0"
    case cellular = "pdp_ip0"
}
