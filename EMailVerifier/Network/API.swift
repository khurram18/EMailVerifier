//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public enum ResponseStatus: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case fail
  case success
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "FAIL": self = .fail
      case "SUCCESS": self = .success
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .fail: return "FAIL"
      case .success: return "SUCCESS"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ResponseStatus, rhs: ResponseStatus) -> Bool {
    switch (lhs, rhs) {
      case (.fail, .fail): return true
      case (.success, .success): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ResponseStatus] {
    return [
      .fail,
      .success,
    ]
  }
}

public final class UserRegistrationMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation UserRegistration($email: String!, $password: String!) {
      userRegistration(email: $email, password: $password) {
        __typename
        status
        message
      }
    }
    """

  public let operationName = "UserRegistration"

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("userRegistration", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")], type: .nonNull(.object(UserRegistration.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(userRegistration: UserRegistration) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "userRegistration": userRegistration.resultMap])
    }

    public var userRegistration: UserRegistration {
      get {
        return UserRegistration(unsafeResultMap: resultMap["userRegistration"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "userRegistration")
      }
    }

    public struct UserRegistration: GraphQLSelectionSet {
      public static let possibleTypes = ["UserRegistrationResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .nonNull(.scalar(ResponseStatus.self))),
        GraphQLField("message", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: ResponseStatus, message: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserRegistrationResponse", "status": status, "message": message])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: ResponseStatus {
        get {
          return resultMap["status"]! as! ResponseStatus
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var message: String? {
        get {
          return resultMap["message"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }
    }
  }
}

public final class UserVerifyEmailMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation UserVerifyEmail($email: String!, $token: String!) {
      userVerifyEmail(email: $email, token: $token) {
        __typename
        status
        message
      }
    }
    """

  public let operationName = "UserVerifyEmail"

  public var email: String
  public var token: String

  public init(email: String, token: String) {
    self.email = email
    self.token = token
  }

  public var variables: GraphQLMap? {
    return ["email": email, "token": token]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("userVerifyEmail", arguments: ["email": GraphQLVariable("email"), "token": GraphQLVariable("token")], type: .nonNull(.object(UserVerifyEmail.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(userVerifyEmail: UserVerifyEmail) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "userVerifyEmail": userVerifyEmail.resultMap])
    }

    public var userVerifyEmail: UserVerifyEmail {
      get {
        return UserVerifyEmail(unsafeResultMap: resultMap["userVerifyEmail"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "userVerifyEmail")
      }
    }

    public struct UserVerifyEmail: GraphQLSelectionSet {
      public static let possibleTypes = ["UserVerifyEmailResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .nonNull(.scalar(ResponseStatus.self))),
        GraphQLField("message", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: ResponseStatus, message: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserVerifyEmailResponse", "status": status, "message": message])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: ResponseStatus {
        get {
          return resultMap["status"]! as! ResponseStatus
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var message: String? {
        get {
          return resultMap["message"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }
    }
  }
}
