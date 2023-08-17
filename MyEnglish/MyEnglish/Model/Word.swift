//
//  Word.swift
//  MyEnglish
//
//  Created by Nikita Skripka on 27.06.2023.
//

import Foundation
import UIKit

struct Word: Equatable, Codable {
    let id = UUID()
    var englishWord: String
    var russianWord: String
    var wordLevel: String
    var image: UIImage?
    
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentDirectory.appendingPathComponent("Words").appendingPathExtension("plist")
    
    enum CodingKeys: String, CodingKey {
        case englishWord
        case russianWord
        case wordLevel
        case image
    }
    
    static func ==(lhs: Word, rhs: Word) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func loadWords() -> [Word]? {
        guard let codedWords = try? Data(contentsOf: archiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Word>.self, from: codedWords)
    }
    
    static func saveWords(_ words: [Word]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedWords = try? propertyListEncoder.encode(words)
        try? codedWords?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadSampleWords() -> [Word] {
        let word1 = Word(englishWord: "Hello", russianWord: "Привет", wordLevel: "A0", image: UIImage(named: "hello"))
        let word2 = Word(englishWord: "Cat", russianWord: "Кошка", wordLevel: "A0", image: UIImage(named: "cat"))
        let word3 = Word(englishWord: "Bird", russianWord: "Птица", wordLevel: "A0", image: UIImage(named: "bird"))
        
        return [word1, word2, word3]
    }
    
    //соответствие протоколу Сodable
    init(englishWord: String, russianWord: String, wordLevel: String, image: UIImage?) {
        self.englishWord = englishWord
        self.russianWord = russianWord
        self.wordLevel = wordLevel
        self.image = image
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        englishWord = try values.decode(String.self, forKey: .englishWord)
        russianWord = try values.decode(String.self, forKey: .russianWord)
        wordLevel = try values.decode(String.self, forKey: .wordLevel)
        image = try values.decodeIfPresent(UIImage.self, forKey: .image)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(englishWord, forKey: .englishWord)
        try container.encode(russianWord, forKey: .russianWord)
        try container.encode(wordLevel, forKey: .wordLevel)
        try container.encodeIfPresent(image, forKey: .image)
    }
}

//Позволяет сохранить тип UIImage на диск
public protocol ImageCodable: Codable {}
extension UIImage: ImageCodable {}

extension ImageCodable where Self: UIImage {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(data: try container.decode(Data.self))!
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.pngData()!)
    }
}
