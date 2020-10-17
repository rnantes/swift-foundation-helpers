//
//  File.swift
//  
//
//  Created by Reid Nantes on 2020-02-17.
//

import Foundation

extension URL {
    /// initailized a url if the given string is not nil
    public init?(string stringOptional: String?) {
        guard let string = stringOptional else {
            return nil
        }
        self.init(string: string)
    }

    /// returns a new url with the given  queryItems (query parameters) added
    public func appendingQueryItems(queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents.init(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }

        // Create array of existing query items
        var currentQueryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Append new query items to currentQueryItems
        currentQueryItems.append(contentsOf: queryItems)

        urlComponents.queryItems = currentQueryItems

        // Returns the url from new url components
        guard let newURL = urlComponents.url else {
            return nil
        }

        return newURL
    }

    public func appendingURL(_ url: URL) -> URL {
        self.appendingPathComponent(url.path)
    }

    public func appendingURLIfExists(_ url: URL?) -> URL {
        if let path = url?.path {
            return self.appendingPathComponent(path)
        }
        return self
    }

    public var addedToDirectoryDate: Date? {
        do {
            return try self.resourceValues(forKeys: [.addedToDirectoryDateKey]).addedToDirectoryDate
        } catch {
            return nil
        }
    }

    public var createdToDirectoryDate: Date? {
        do {
            return try self.resourceValues(forKeys: [.creationDateKey]).creationDate
        } catch {
            return nil
        }
    }
}

public enum FoundationHelperURLError: Error {
    case couldNotUnwrapURL
}

public extension Optional where Wrapped == URL {

    func unwrapOrThrow() throws -> URL {
        guard let url = self else {
            throw FoundationHelperURLError.couldNotUnwrapURL
        }
        return url
    }

}
