//
//  LocalStorage.swift
//  VService
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import Foundation
import VCore

public class LocalStorage {
    public static var shared = LocalStorage(name: "VSLocal")

    var userDefaults: UserDefaults?

    private init(name: String) {
        userDefaults = UserDefaults(suiteName: name)
    }

    func set(_ obj: Any?, forKey key: String) {
        userDefaults?.setValue(obj, forKey: key)
    }

    func get<Obj>(forKey key: String) -> Obj? {
        userDefaults?.value(forKey: key) as? Obj
    }
}
