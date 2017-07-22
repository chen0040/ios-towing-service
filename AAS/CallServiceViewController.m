//
//  CallServiceViewController.m
//  AAS
//
//  Created by Chen Xianshun on 20/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CallServiceViewController.h"
#import "AccInfo.h"
#import "HistoryManager.h"
#import "RoadsideAssistanceViewController.h"

static NSString* PushViewRoadsideAssistanceSegueIdentifier=@"Push Roadside Assistance";

@interface CallServiceViewController ()

@end

@implementation CallServiceViewController
@synthesize account=_account;
@synthesize historyManager=_historyManager;
@synthesize carColorField = _carColorField;
@synthesize userIdField = _userIdField;
@synthesize contactNumberField = _contactNumberField;
@synthesize carNumberField = _carNumberField;
@synthesize carMakeField = _carMakeField;
@synthesize carModelField = _carModelField;
@synthesize idTypeField = _idTypeField;
@synthesize nameField = _nameField;

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
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setUserIdField:nil];
    [self setIdTypeField:nil];
    [self setNameField:nil];
    [self setContactNumberField:nil];
    [self setCarNumberField:nil];
    [self setCarMakeField:nil];
    [self setCarModelField:nil];
    [self setCarColorField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.userIdField.text=self.account.userId;
    self.nameField.text=self.account.name;
    self.idTypeField.selectedSegmentIndex=self.account.idType;
    self.contactNumberField.text=self.account.contactNumber;
    self.carNumberField.text=self.account.carNumber;
    self.carMakeField.text=self.account.carMake;
    self.carModelField.text=self.account.carModel;
    self.carColorField.text=self.account.carColor;
}

- (void) showAlert: (NSString*)msg
{
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Input Invalid!" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)doGoNext:(id)sender 
{
    if([self.userIdField.text isEqualToString:@""])
    {
        [self showAlert:@"User ID cannot be empty!"];
        return;
    }
    
    if([self.nameField.text isEqualToString:@""])
    {
        [self showAlert:@"Name cannot be empty!"];
        return;
    }
    
    if([self.contactNumberField.text isEqualToString:@""])
    {
        [self showAlert:@"Contact Number cannot be empty!"];
        return;
    }
    
    if([self.carNumberField.text isEqualToString:@""])
    {
        [self showAlert:@"Car Number cannot be empty!"];
        return;
    }
    
    if([self.carModelField.text isEqualToString:@""])
    {
        [self showAlert:@"Car Model cannot be empty!"];
        return;
    }
    
    if([self.carMakeField.text isEqualToString:@""])
    {
        [self showAlert:@"Car Make cannot be empty!"];
        return;
    }
    
    if([self.carColorField.text isEqualToString:@""])
    {
        [self showAlert:@"Car Color cannot empty!"];
        return;
    }
    
    [self performSegueWithIdentifier:PushViewRoadsideAssistanceSegueIdentifier sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:PushViewRoadsideAssistanceSegueIdentifier])
    {
        self.account.userId=self.userIdField.text;
        self.account.name=self.nameField.text;
        self.account.idType=self.idTypeField.selectedSegmentIndex;
        self.account.contactNumber=self.contactNumberField.text;
        self.account.carNumber=self.carNumberField.text;
        self.account.carMake=self.carMakeField.text;
        self.account.carModel=self.carModelField.text;
        self.account.carColor=self.carColorField.text;
    
        [self.account saveToDisk];
        RoadsideAssistanceViewController* controller=segue.destinationViewController;
        controller.account=self.account;
        controller.historyManager=self.historyManager;
    }
}
@end
