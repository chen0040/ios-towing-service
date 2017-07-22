//
//  MenuViewController.m
//  AAS
//
//  Created by Chen Xianshun on 20/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "AccInfo.h"
#import "HistoryManager.h"
#import "CallServiceViewController.h"
#import "HistoryViewController.h"
#import "ServiceMonitorViewController.h"
#import "ServiceOnlineViewController.h"

static NSString* PushCallServiceSegueIdentifier=@"Push Call Service";
static NSString* PushViewHistorySegueIdentifier=@"Push View History";
static NSString* PushServiceMonitorSegueIdentifier=@"Push Service Monitor";
static NSString* PushServiceOnlineSegueIdentifier=@"Push Service Online";



@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize account=_account;
@synthesize historyManager=_historyManager;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    //self.navigationController.navigationBar.tintColor=[UIColor greenColor];
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _account=[[AccInfo alloc] init];
    _historyManager=[[HistoryManager alloc] init];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:PushCallServiceSegueIdentifier])
    {
        CallServiceViewController* controller=segue.destinationViewController;
        controller.historyManager=self.historyManager;
        controller.account=self.account;
    }
    else if([segue.identifier isEqualToString:PushViewHistorySegueIdentifier])
    {
        HistoryViewController* controller=segue.destinationViewController;
        controller.historyManager=self.historyManager;
        controller.account=self.account;
    }
    else if([segue.identifier isEqualToString:PushServiceMonitorSegueIdentifier])
    {
        ServiceMonitorViewController* controller=segue.destinationViewController;
        controller.historyManager=self.historyManager;
        controller.account=self.account;
    }
    else if([segue.identifier isEqualToString:PushServiceOnlineSegueIdentifier])
    {
        ServiceOnlineViewController* controller=segue.destinationViewController;
        controller.historyManager=self.historyManager;
        controller.account=self.account;
    }
}


@end
