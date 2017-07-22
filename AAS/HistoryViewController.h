//
//  HistoryViewController.h
//  AAS
//
//  Created by Chen Xianshun on 20/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccInfo;
@class HistoryManager;

@interface HistoryViewController : UITableViewController
@property(nonatomic, strong) AccInfo* account;
@property(nonatomic, strong) HistoryManager* historyManager;

-(void) handleHistoryChanged: (NSNotification*)notification;
@end
