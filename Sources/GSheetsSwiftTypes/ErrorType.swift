//
//  ErrorType.swift
//  
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

public enum ErrorType: String, Codable {
    case error_type_unspecified = "ERROR_TYPE_UNSPECIFIED"
    case error = "ERROR"
    case null_value = "NULL_VALUE"
    case divider_by_zero = "DIVIDE_BY_ZERO"
    case value = "VALUE"
    case ref = "REF"
    case name = "NAME"
    case num = "NUM"
    case n_a = "N_A"
    case loadin = "LOADIN"
}
