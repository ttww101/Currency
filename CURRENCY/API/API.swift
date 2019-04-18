//
//  CurrencyAPI.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 30/11/2017.
//  Copyright © 2017 Meiliang Wen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class API {

  lazy var alamofireSession: Alamofire.SessionManager = {
    let _manager = Alamofire.SessionManager.default
    _manager.session.configuration.timeoutIntervalForRequest = 10.0
    _manager.session.configuration.timeoutIntervalForResource = 10.0
    return _manager
  }()

  func detectInternet<T>(_ errorHandler: ((T?, Error?) -> Void)?) -> Bool {
    guard ReachabilityWorker.shared.isReachable else {
      let error = NetworkError.noInternet
      errorHandler?(nil, error)
      return false
    }
    return true
  }

  func history(source: Source,
               completion: @escaping ([HistoryModelize]?, Error?) -> Void) {
    switch source {
    case .google:
      alamofireSession.request(source.url,
                               method: .post,
                               encoding: URLEncoding(destination: .queryString)).responseString { (response) in

                                guard response.result.isSuccess == true else {
                                  completion(nil, response.error)
                                  return
                                }
                                guard let value = response.result.value,
                                  let period = source.period else {
                                    completion(nil, response.error)
                                    return
                                }
                                let histories = APIAnalyzer().google(stringValue: value,
                                                                     interval: period.interval)
                                completion(histories, nil)
      }
    // Yahoo
    default:
      print("")
    }
  }

  func highestCurrencyOfBanks(source: Source,
                              completion: @escaping ([RterBank<RterCurrency>]?, Error?) -> Void) {
    switch source {
    case .rter(let rter, let exchangeType):
      guard let exchangeType = exchangeType else { return }
      alamofireSession.request(rter.url(exchange: exchangeType), method: .get).validate().responseJSON { (response) in

        switch response.result {
        case .success(let value):
          let json = JSON(value)
          guard let banks = APIAnalyzer().rterCurrency(rter: rter, json: json) else {
            completion(nil, nil)
            return
          }
          completion(banks, nil)
        case .failure(let error):
          Debug.print(error)
          completion(nil, error)
        }
      }
    default:
      print("")
    }
  }

  func currenciesOfBank(source: Source,
                        completion: @escaping (RterBank<[RterCurrency]>?, Error?) -> Void) {
    switch source {
    case .rter(let rter, let exchangeType):
    
      
      guard let exchangeType = exchangeType else { return }
      alamofireSession.request(rter.url(exchange: exchangeType), method: .get).validate().responseJSON { (response) in
        
        switch response.result {
        case .success(let value):
          let json = JSON(value)
          
          guard let bank = APIAnalyzer().rterBank(rter: rter, json: json) else {
            completion(nil, nil)
            return
          }
          completion(bank, nil)
        case .failure(let error):
          Debug.print(error)
          completion(nil, error)
        }
      }
    default:
      print("")
    }
  }

  func getBankOfTaiwanAllToday(completion: @escaping (CurrencySource?, Error?) -> Void) {
    alamofireSession.request(Source.bot(nil, nil).url, method: .get).validate().responseString { (response) in
      switch response.result {
      case .success(let value):
        let json = JSON(value)
        let source = APIAnalyzer().bankOfTaiwanAllToday(json: json)
        completion(source, nil)
      case .failure(let error):
        Debug.print(error)
        completion(nil, error)
      }
    }
  }

  func getBankOfTaiwan(subject: String, period: Period, completion: @escaping (InvestmentSubject?, Error?) -> Void) {
    // Subject is Uppercased, e.g. USD
    alamofireSession.request(Source.bot(subject, period).url, method: .get).validate().responseString { (response) in
      switch response.result {
      case .success(let value):
        let json = JSON(value)
        let investmentSubject = APIAnalyzer().bankOfTaiwan(subject: subject, period: period, json: json)
        completion(investmentSubject, nil)
      case .failure(let error):
        Debug.print(error)
        completion(nil, error)
      }
    }
  }
}
