//
//  DebugPrint.swift
//  iOSTask
//
//  Created by Mohamed Nabil on 16/08/2024.
//

import Foundation

public func print(_ objects: Any...) {
#if DEBUG
    for item in objects {
        Swift.print(item)
    }
#endif
}


public func print(_ object: Any) {
#if DEBUG
    Swift.print(object)
#endif
}
