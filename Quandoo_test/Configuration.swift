//
//  Configuration.swift
//  Quandoo_test
//
//  Created by Vladimir Gnatiuk on 11/9/16.
//  Copyright © 2016 Vladimir Gnatiuk. All rights reserved.
//

import Foundation

public class Configuration: NSObject {

    /// shared instance of Configuration (singleton)
    static let sharedConfig : Configuration = Configuration()

    /// base URL for Router
    public var baseURL = ""

    public var apiVersion = ""

    /**
     Reads configuration file
     */
    override init() {
        super.init()
        self.readConfigs()
    }

    // MARK: private methods

    /**
     * read configs from plist
     */
    private func readConfigs() {
        if let path = getConfigurationResourcePath() {
            let configDicts = NSDictionary(contentsOfFile: path)
            baseURL = configDicts?["baseURL"] as? String ?? baseURL
            apiVersion = configDicts?["apiVersion"] as? String ?? apiVersion
        }
        else {
            assert(false, "configuration is not found")
        }
    }

    /**
     Get the path to the configuration.plist.

     - returns: the path to configuration.plist
     */
    private func getConfigurationResourcePath() -> String? {
        return Bundle(for: Configuration.classForCoder()).path(forResource: "configuration", ofType: "plist")
    }
}
