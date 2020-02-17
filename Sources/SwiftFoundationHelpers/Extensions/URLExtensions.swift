//
//  File.swift
//  
//
//  Created by Reid Nantes on 2020-02-17.
//

import Foundation

extension URL {
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
