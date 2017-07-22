//
//  MasterModeViewController.h
//  AAS
//
//  Created by Chen Xianshun on 24/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterModeViewController : UIViewController
- (IBAction)doRemoveAllCompletedRequests:(id)sender;
- (IBAction)doRemoveAllSubmittedRequests:(id)sender;
- (IBAction)doRemoveAllCancelledRequests:(id)sender;

@property (strong, nonatomic) NSMutableData* data;
@property (strong, nonatomic) NSURLConnection* connection;

@end
