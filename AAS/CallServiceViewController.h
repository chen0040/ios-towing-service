//
//  CallServiceViewController.h
//  AAS
//
//  Created by Chen Xianshun on 20/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccInfo;
@class HistoryManager;

@interface CallServiceViewController : UITableViewController
@property(nonatomic, strong) AccInfo* account;
@property(nonatomic, strong) HistoryManager* historyManager;
@property (strong, nonatomic) IBOutlet UITextField *carColorField;
@property (strong, nonatomic) IBOutlet UITextField *userIdField;
@property (strong, nonatomic) IBOutlet UITextField *contactNumberField;
@property (strong, nonatomic) IBOutlet UITextField *carNumberField;
@property (strong, nonatomic) IBOutlet UITextField *carMakeField;
@property (strong, nonatomic) IBOutlet UITextField *carModelField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *idTypeField;
@property (strong, nonatomic) IBOutlet UITextField *nameField;

- (IBAction)doGoNext:(id)sender;

- (void) showAlert: (NSString*)msg;

@end
