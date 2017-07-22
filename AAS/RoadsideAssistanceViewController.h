//
//  RoadsideAssistanceViewController.h
//  AAS
//
//  Created by Chen Xianshun on 20/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    SubmitServiceCall,
    None
} RequestAction;

@class AccInfo;
@class HistoryManager;
@class HistoryEntry;

@interface RoadsideAssistanceViewController : UITableViewController<CLLocationManagerDelegate, UIActionSheetDelegate>{
    CLLocationManager *locationManager;
}
- (IBAction)doSubmit:(id)sender;
- (IBAction)doGetAddress:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *breakdownLocationField;
@property (strong, nonatomic) IBOutlet UITextView *noteField;
@property (strong, nonatomic) NSMutableData* data;
@property (strong, nonatomic) NSURLConnection* connection;
@property (assign, nonatomic) RequestAction currentRequest;

@property(nonatomic, strong) AccInfo* account;
@property(nonatomic, strong) HistoryManager* historyManager;
@property(nonatomic, strong) CLLocation* currentLocation;
@property(nonatomic, strong) CLLocation* reportLocation;
- (IBAction)doClear:(id)sender;
- (IBAction)doDummyChoose:(id)sender;

- (void) showAlert: (NSString*)msg;
- (NSString*) createSubmitRequest:(HistoryEntry*)history;

@end
