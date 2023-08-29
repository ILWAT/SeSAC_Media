//
//  UserData.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/29.
//

import Foundation


struct UserData{
    var name: String = "이름"
    var userName: String = "사용자 이름"
    var genderReplacement: String = "성별 대명사"
    var introduce: String = "소개"
    var link: String = "링크 추가"
    var gender: Gender = .unknown
    
    enum Gender: String{
        case man = "남성"
        case woman = "여성"
        case unknown = "미정"
    }
    
    enum dataCategory: Int{
        case name = 1
        case userName,genderReplacement, introduce, link, gender
    }
    
    func valueReturn(dataType: Int) -> String {
        switch dataType{
        case dataCategory.name.rawValue:
            return name
        case dataCategory.userName.rawValue:
            return userName
        case dataCategory.genderReplacement.rawValue:
            return genderReplacement
        case dataCategory.introduce.rawValue:
            return introduce
        case dataCategory.link.rawValue:
            return link
        case dataCategory.gender.rawValue:
            return gender.rawValue
        default:
            return ""
        }
    }
    
    mutating func chageValue(dataType: Int, newValue: String){
        switch dataType{
        case dataCategory.name.rawValue:
            self.name = newValue
        case dataCategory.userName.rawValue:
            self.userName = newValue
        case dataCategory.genderReplacement.rawValue:
            self.genderReplacement = newValue
        case dataCategory.introduce.rawValue:
            self.introduce = newValue
        case dataCategory.link.rawValue:
            self.link = newValue
        case dataCategory.gender.rawValue:
            self.gender = Gender(rawValue: newValue) ?? .unknown
        default:
            print("실패")
        }
    }
}
