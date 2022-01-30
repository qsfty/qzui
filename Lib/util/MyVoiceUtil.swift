//
// Created by 强子 on 2021/10/12.
//

import Foundation
import AVFoundation
public struct MyVoiceUtil {

    public static func playTap(){
        AudioServicesPlaySystemSound(1104)
    }

    public static func playNext(){
        AudioServicesPlaySystemSound(1057)
    }

    public static func playYes(){
        AudioServicesPlaySystemSound(1002)
    }

    public static func playNo(){
        AudioServicesPlaySystemSound(1026)
    }

    public static func shock(){
        AudioServicesPlaySystemSound(1520);
    }
}