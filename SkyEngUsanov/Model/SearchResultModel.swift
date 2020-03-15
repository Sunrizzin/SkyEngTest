//
//  SearchResultModel.swift
//  SkyEngUsanov
//
//  Created by Aleksey Usanov on 15.03.2020.
//  Copyright © 2020 Aleksey Usanov. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class SearchResult: Object, Mappable {
    @objc dynamic var id: Int              = 0
    var meanings = List<Meanings>()
    @objc dynamic var text: String         = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        id          <- map["id"]
        meanings    <- map["meanings"]
        text        <- map["text"]
    }
}

class Meanings: Object, Mappable {
    @objc dynamic var id: Int                    = 0
    @objc dynamic var imageUrl: String           = ""
    @objc dynamic var partOfSpeechCode: String   = ""
    @objc dynamic var previewUrl: String         = ""
    @objc dynamic var soundUrl: String           = ""
    @objc dynamic var transcription: String      = ""
    @objc dynamic var translation: Translation?  = nil
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        id                  <- map["id"]
        imageUrl            <- map["imageUrl"]
        partOfSpeechCode    <- map["partOfSpeechCode"]
        previewUrl          <- map["previewUrl"]
        soundUrl            <- map["soundUrl"]
        transcription       <- map["transcription"]
        translation         <- map["translation"]
    }
}

class Translation: Object, Mappable {
    @objc dynamic var note: String = ""
    @objc dynamic var text: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        note <- map["note"]
        text <- map["text"]
    }
}


func <- <T: Mappable>(left: List<T>, right: Map)
{
    var array: [T]?
    
    if right.mappingType == .toJSON {
        array = Array(left)
    }
    
    array <- right
    
    if right.mappingType == .fromJSON {
        if let theArray = array {
            left.append(objectsIn: theArray)
        }
    }
}
