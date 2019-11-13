//
//  FileManagerExtensions.swift
//  MapleWeatherParser
//
//  Created by Reid Nantes on 2019-08-04.
//

import Foundation

extension FileManager {
    func createDirectoryIfItDoesNotExits(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey: Any]? = nil) throws {
        if self.fileExists(atPath: url.path) {
            return
        } else {
            try self.createDirectory(at: url, withIntermediateDirectories: createIntermediates, attributes: attributes)
        }
    }

    func filesOfDirectory(at url: URL) throws -> [URL] {
        return try self.contentsOfDirectory(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants, .skipsSubdirectoryDescendants])
    }

    func filesOfDirectorySortedByDate(_ url: URL) throws -> [URL] {
        let fileURLs = try self.contentsOfDirectory(at: url,
                                                    includingPropertiesForKeys: [.isRegularFileKey, .addedToDirectoryDateKey],
                                                    options: [.skipsHiddenFiles, .skipsPackageDescendants, .skipsSubdirectoryDescendants])
        return fileURLs.sorted(by: {
            if let firstDate = $0.addedToDirectoryDate, let secondDate = $1.addedToDirectoryDate {
                return firstDate > secondDate
            } else {
                if $0.addedToDirectoryDate != nil {
                    return true
                } else if $1.addedToDirectoryDate != nil {
                    return false
                } else {
                    return true
                }
            }
        })
    }

    func lastAddedFileToDirectoy(_ directory: URL) throws -> URL? {
        return try filesOfDirectorySortedByDate(directory).first
    }

}

extension URL {
    var addedToDirectoryDate: Date? {
        do {
            return try self.resourceValues(forKeys: [.addedToDirectoryDateKey]).addedToDirectoryDate
        } catch {
            return nil
        }
    }

    var createdToDirectoryDate: Date? {
        do {
            return try self.resourceValues(forKeys: [.creationDateKey]).creationDate
        } catch {
            return nil
        }
    }
}
