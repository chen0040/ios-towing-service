//
//  HistoryDetailViewController.h
//  AAS
//
//  Created by Chen Xianshun on 21/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HistoryEntry.h"

@class AccInfo;
@class HistoryManager;

@interface HistoryDetailViewController : UITableViewController<UIActionSheetDelegate>
@property(nonatomic, strong) AccInfo* account;
@property(nonatomic, strong) HistoryManager* historyManager;
@property(nonatomic, assign) RequestStatus newStatus;
@property (strong, nonatomic) NSMutableData* data;
@property (strong, nonatomic) NSURLConnection* connection;
@property (strong, nonatomic) IBOutlet UILabel *userIdField;
@property (strong, nonatomic) IBOutlet UILabel *contactNumberField;
@property (strong, nonatomic) IBOutlet UILabel *carNumberField;
@property(nonatomic, assign) NSUInteger selectedIndex;
@property (strong, nonatomic) IBOutlet UILabel *carMakeField;
@property (strong, nonatomic) IBOutlet UILabel *carColorField;
@property (strong, nonatomic) IBOutlet UILabel *carModelField;
@property (strong, nonatomic) IBOutlet UILabel *coordinateField;
@property (strong, nonatomic) IBOutlet UILabel *addressField;
@property (strong, nonatomic) IBOutlet UILabel *causeField;
@property (strong, nonatomic) IBOutlet UILabel *statusField;
- (IBAction)doAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *nameField;

- (NSString*) createRequest:(HistoryEntry*)history;
- (NSString*) deleteRequest: (HistoryEntry*)history;
@end
