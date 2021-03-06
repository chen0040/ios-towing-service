//
//  ServiceDetailViewController.h
//  AAS
//
//  Created by Chen Xianshun on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccInfo;
@class HistoryManager;

@interface ServiceDetailViewController : UIViewController<UIWebViewDelegate>

@property(retain, nonatomic) NSString* marker_id;
@property (retain, nonatomic) IBOutlet UIWebView *myWebView;
@property(nonatomic, strong) AccInfo* account;
@property(nonatomic, strong) HistoryManager* historyManager;

@end
