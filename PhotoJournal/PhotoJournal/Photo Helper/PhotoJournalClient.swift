//
//  PhotoJournalClient.swift
//  PhotoJournal
//
//  Created by Alyson Abril on 1/27/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class PhotoHelperClient {
    private static let filename = "PhototJournalList.plist"
    private static var items = [PhotoJournal]()
    
    static func getPhotoJournal() -> [PhotoJournal]{
        let path  = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    items = try PropertyListDecoder().decode([PhotoJournal].self, from: data)
                } catch {
                    print("property list decoding error: \(error)")
                }
            } else {
                print("getPhotoJournal - data is nil")
            }
        } else {
            print("\(filename) does not exist")
        }
        return items
    }
    
    static func addItem(item: PhotoJournal) {
        items.append(item)
        save()
    }
    
    static func delete(item: ItemModel, atindex index: Int) {
        items.remove(at: index)
        save()
    }
    
    static func save() {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(items)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoding error: \(error)")
        }
    }
}
