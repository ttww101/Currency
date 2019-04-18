//
//  ErrorHandlerConfiguration.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 02/04/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import ErrorHandler
import KVNProgress
import Fabric
import Crashlytics
//
//class SErrorHandler: ErrorHandler {
//}
//
//extension ErrorHandler {
//  class var defaultHandler: ErrorHandler {
//    return ErrorHandler()
//      .always(do: { (_) -> MatchingPolicy in
//        // Always do handling error before
//        return .continueMatching
//      })
//      .tag(NSErrorMatcher(domain: NSURLErrorDomain, code: NSURLErrorNetworkConnectionLost), with: "ConnectionError")
//      .tag(NSErrorMatcher(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet), with: "ConnectionError")
//      .tag(NSErrorMatcher(domain: NSURLErrorDomain, code: NSURLErrorTimedOut), with: "ConnectionError")
//      .on(tag: "ConnectionError", do: { (_) -> MatchingPolicy in
//        KVNProgress.showError(withStatus: NetworkError.noInternet.localizedDescription)
//        return .continueMatching
//      })
//      .onAFError(withStatus: 400..<451, do: { (_) -> MatchingPolicy in
//        KVNProgress.showError(withStatus: NetworkError.noInternet.localizedDescription)
//        return .continueMatching
//      })
//      .onAFError(withStatus: 500..<512, do: { (_) -> MatchingPolicy in
//        KVNProgress.showError(withStatus: NetworkError.server.localizedDescription)
//        return .continueMatching
//      })
//      .onAFError(withStatus: 1001..<2102, do: { (error) -> MatchingPolicy in
//        KVNProgress.showError(withStatus: error.localizedDescription)
//        return .continueMatching
//      })
//      .on(LoadDataError.empty, do: { (_) -> MatchingPolicy in
//        KVNProgress.showError(withStatus: LoadDataError.empty.localizedDescription)
//        return .stopMatching
//      })
//      .on(NetworkError.server, do: { (_) -> MatchingPolicy in
//        KVNProgress.showError(withStatus: NetworkError.server.localizedDescription)
//        return .stopMatching
//      })
//      .on(NetworkError.noInternet, do: { (_) -> MatchingPolicy in
//        KVNProgress.showError(withStatus: NetworkError.noInternet.localizedDescription)
//        return .stopMatching
//      })
//      .onError(ofType: UserSettingError.self, do: { (error) -> MatchingPolicy in
//        // Parsing error to Crashlystic
//        guard let error = error as? UserSettingError else { return .stopMatching }
//        Crashlytics.sharedInstance().recordError(error)
//        Answers.logCustomEvent(withName: "UserSettingError",
//                               customAttributes: ["device": DeviceKit.version,
//                                                  "os": DeviceKit.osVersion,
//                                                  "device_code": DeviceKit.versionCode,
//                                                  "description": error.localizedDescription])
//        return .stopMatching
//      })
//      .onNoMatch(do: { (_) -> MatchingPolicy in
//        KVNProgress.showError(withStatus: LanguageWorker.shared.localizedString(key: R.string.error.unknown_error.key,
//                                                                                table: .appError))
//        return .stopMatching
//      })
//    }
//}
