//
//  DataOnlineViewController.h
//  AAS
//
//  Created by Chen Xianshun on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccInfo;
@class HistoryManager;

@interface DataOnlineViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property(nonatomic, strong) AccInfo* account;
@property(nonatomic, strong) HistoryManager* historyManager;
@end
