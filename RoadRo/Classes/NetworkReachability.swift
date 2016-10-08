//
//  NetworkReachability.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Reachability

// Notifications
public let kDidUpdateInternetReaachability = "kDidUpdateInternetReachability"

public class NetworkReachability {
  public var reachable : Bool = false {
    didSet {
    }
  }
  public var reachableViaWifi : Bool = false
  
  private var internetReach: Reachability!
  
  public init() {
    self.internetReach = Reachability()
    
    internetReach.whenReachable = { [unowned self] (reach: Reachability!) in
      self.manageInternetReachability(reachability: reach)
    }
    internetReach.whenUnreachable = { [unowned self] (reach: Reachability!) in
      self.manageInternetReachability(reachability: reach)
    }
    
    do {
      try internetReach.startNotifier()
    } catch {
      print("\n\n !!! - Unable to start notifier")
    }
    
    self.reachable = internetReach.isReachable
    self.reachableViaWifi = internetReach.isReachableViaWiFi
  }
  
  
  private func manageInternetReachability(reachability: Reachability) {
    let reachability = reachability
    
    if reachability.isReachable {
      if reachability.isReachableViaWiFi {
        self.updateInternetReachability(reachability: reachability)

      } else {
        self.updateInternetReachability(reachability: reachability)

      }
    } else {
      self.updateInternetReachability(reachability: reachability)
    }
  }
  
  private func updateInternetReachability(reachability: Reachability) {
    DispatchQueue.main.async {
      self.reachable = reachability.isReachable
      self.reachableViaWifi = reachability.isReachableViaWiFi
    }
  }

}
