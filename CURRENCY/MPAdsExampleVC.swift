////
////  MPAdsExampleVC.swift
////  CURRENCY
////
////  Created by Stan Liu on 2018/4/24.
////  Copyright © 2018 Stan Liu. All rights reserved.
////
//
//import UIKit
//
//class MPAdsExampleVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//  var datas: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
//  lazy var tableView: UITableView = {
//    return UITableView(frame: CGRect.zero, style: .plain)
//  }()
//  lazy var mpAdsViewModel: MPAdsViewModel = {
//    return MPAdsViewModel(adsPosition: .fix(0), // 0 means the first row
//                          tableView: tableView,
//                          cellClass: FBAdCell.self,
//                          viewController: self)
//  }()
//
//  lazy var mpFullPageViewModel: MPFullPageViewModel = {
//    return MPFullPageViewModel.shared
//  }()
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    tableView.mp_setDelegate(self)
//    tableView.mp_setDataSource(self)
//    view.addSubview(tableView)
//    tableView.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate([
//      tableView.topAnchor.constraint(equalTo: view.topAnchor),
//      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
//      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//      tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
//      ])
//
//    tableView.reloadData()
//    mpAdsViewModel.registerAdCell(tableView: tableView,
//                                  cellNib: R.nib.fbAdCell(),
//                                  reuseIdentifier: "Cell")
//    mpAdsViewModel.loadAds()
//    //mpFullPageViewModel.loadAds()
//  }
//
//  func numberOfSections(in tableView: UITableView) -> Int {
//    return 1
//  }
//
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return datas.count
//  }
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    guard let cell = tableView.mp_dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FBAdCell else {
//      return FBAdCell()
//    }
//    cell.textLabel?.text = datas[indexPath.row]
//    return cell
//  }
//}
