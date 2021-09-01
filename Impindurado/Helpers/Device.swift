//
//  Devices.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 16/08/21.
//

import UIKit

public enum Device: String {
    case IPodTouch5
    case IPodTouch6
    case IPhone4
    case IPhone4S
    case IPhone5
    case IPhone5C
    case IPhone5S
    case IPhone6
    case IPhone6Plus
    case IPhone6S
    case IPhone6SPlus
    case IPhone7
    case IPhone7Plus
    case IPhoneSE
    case IPad2
    case IPad3
    case IPad4
    case IPadAir
    case IPadAir2
    case IPadMini
    case IPadMini2
    case IPadMini3
    case IPadMini4
    case IPadPro
    case AppleTV
    case Simulator
    case Other
}

public extension UIDevice {

    var modelName: Device {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        switch identifier {
        case "iPod5,1":                                 return Device.IPodTouch5
        case "iPod7,1":                                 return Device.IPodTouch6
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return Device.IPhone4
        case "iPhone4,1":                               return Device.IPhone4S
        case "iPhone5,1", "iPhone5,2":                  return Device.IPhone5
        case "iPhone5,3", "iPhone5,4":                  return Device.IPhone5C
        case "iPhone6,1", "iPhone6,2":                  return Device.IPhone5S
        case "iPhone7,2":                               return Device.IPhone6
        case "iPhone7,1":                               return Device.IPhone6Plus
        case "iPhone8,1":                               return Device.IPhone6S
        case "iPhone8,2":                               return Device.IPhone6SPlus
        case "iPhone9,1", "iPhone9,3":                  return Device.IPhone7
        case "iPhone9,2", "iPhone9,4":                  return Device.IPhone7Plus
        case "iPhone8,4":                               return Device.IPhoneSE
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return Device.IPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":           return Device.IPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":           return Device.IPad4
        case "iPad4,1", "iPad4,2", "iPad4,3":           return Device.IPadAir
        case "iPad5,3", "iPad5,4":                      return Device.IPadAir2
        case "iPad2,5", "iPad2,6", "iPad2,7":           return Device.IPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":           return Device.IPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":           return Device.IPadMini3
        case "iPad5,1", "iPad5,2":                      return Device.IPadMini4
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return Device.IPadPro
        case "AppleTV5,3":                              return Device.AppleTV
        case "i386", "x86_64":                          return Device.Simulator
        default:                                        return Device.Other
        }
    }
    
    static var is4InchDevice: Bool {
        return UIApplication.shared.windows.first?.bounds.width ?? 0 == 320
    }

}
