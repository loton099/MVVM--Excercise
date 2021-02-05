//
//  User.swift
//  MVVM-Exercise
//
//  Created by Shakti Prakash Srichandan on 03/02/21.
//

import Foundation

// MARK: - User
struct User: Codable {
    let id: Int
    let name, username: String
    let address: Address?
    let phone, website: String
    let company: Company?
    var favouriteStatus: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case name, username
        case address
        case phone, website
        case company
        case favouriteStatus
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? HeightConstants.annoymousID
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? SpacingConstants.emptyString
        username = try container.decodeIfPresent(String.self, forKey: .username) ?? SpacingConstants.emptyString
        website = try container.decodeIfPresent(String.self, forKey: .website) ?? SpacingConstants.emptyString
        phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? SpacingConstants.emptyString
        company = try container.decodeIfPresent(Company.self, forKey: .company)
        address = try container.decodeIfPresent(Address.self, forKey: .address)
    }
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String
}

extension User: Displayable {
    var userID: Int {
        return id
    }
    var fullName: String {
       return name
    }
    
    var userName: String {
        return username
    }
    
    var userPhoneNumber: String {
        return phone
    }
    
    var userWebsite: String {
        return  website
    }
    
    var userCompany: String {
        return company?.name ?? SpacingConstants.emptyString
    }
    
    var isfavourite: Bool {
        get {
            return favouriteStatus
        }
        set {
            self.favouriteStatus = newValue
        }
    }
    
    
}
