//
//  ServiceMonitorViewController.h
//  AAS
//
//  Created by Chen Xianshun on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccInfo;
@class HistoryManager;

@interface ServiceMonitorViewController : UIViewController<MKMapViewDelegate>
@property(nonatomic, strong) AccInfo* account;
@property (retain, nonatomic) IBOutlet MKMapView *myMapView;
@property(nonatomic, strong) HistoryManager* historyManager;

-(IBAction)showDetailView:(UIView*)sender;
@end
