//
//  HistoryDetailViewController.m
//  AAS
//
//  Created by Chen Xianshun on 21/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HistoryDetailViewController.h"
#import "HistoryEntry.h"
#import "HistoryManager.h"
#import "NSString+URLEncoding.h"

@interface HistoryDetailViewController ()

@end

@implementation HistoryDetailViewController
@synthesize account=_account;
@synthesize historyManager=_historyManager;
@synthesize userIdField = _userIdField;
@synthesize contactNumberField = _contactNumberField;
@synthesize carNumberField = _carNumberField;
@synthesize selectedIndex=_selectedIndex;
@synthesize carMakeField = _carMakeField;
@synthesize carColorField = _carColorField;
@synthesize carModelField = _carModelField;
@synthesize coordinateField = _coordinateField;
@synthesize addressField = _addressField;
@synthesize causeField = _causeField;
@synthesize statusField = _statusField;
@synthesize nameField = _nameField;
@synthesize data=_data;
@synthesize connection=_connection;
@synthesize newStatus=_currentStatus;

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
    [self setContactNumberField:nil];
    [self setNameField:nil];
    [self setCarNumberField:nil];
    [self setCarMakeField:nil];
    [self setCarColorField:nil];
    [self setCarModelField:nil];
    [self setCoordinateField:nil];
    [self setAddressField:nil];
    [self setCauseField:nil];
    [self setStatusField:nil];
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
    
    HistoryEntry* history=[self.historyManager.histories objectAtIndex:self.selectedIndex];
    
    
    self.nameField.text=history.name;
    NSString* idType=@"NRIC";
    if(history.idType==1) idType=@"PASS";
    else if(history.idType==2) idType=@"FIN";
    
    self.userIdField.text=[NSString stringWithFormat:@"%@ (%@)", history.userId, idType];
    
    self.contactNumberField.text=history.contactNumber;
    self.carNumberField.text=history.carNumber;
    self.carMakeField.text=history.carMake;
    self.carModelField.text=history.carModel;
    self.carColorField.text=history.carColor;
    
    self.coordinateField.text=[NSString stringWithFormat:@"(%.3lf, %.3lf)", history.lat, history.lng];
    self.addressField.text=history.address;
    self.causeField.text=history.note;
    
    NSString* status=@"Submitted";
    if(history.status==requestCompleted)
    {
        status=@"Completed";
    }
    else if(history.status==requestCancel)
    {
        status=@"Canceled";
    }
    self.statusField.text=status;
    self.newStatus=history.status;
}


- (IBAction)doAction:(id)sender 
{
    HistoryEntry* history=[self.historyManager.histories objectAtIndex:self.selectedIndex];

    if(history.status==requestSubmitted)
    {
        UIActionSheet* sheet=[[UIActionSheet alloc] initWithTitle:@"Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Notify Call Service Done" otherButtonTitles:@"Cancel Call Service", nil];
        [sheet showFromBarButtonItem:sender animated:YES];
    }
    else if(history.status==requestCancel)
    {
        UIActionSheet* sheet=[[UIActionSheet alloc] initWithTitle:@"Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Notify Call Service Done" otherButtonTitles:@"Resubmit Call Service", nil];
        [sheet showFromBarButtonItem:sender animated:YES];
    }
    else if(history.status==requestCompleted)
    {
        UIActionSheet* sheet=[[UIActionSheet alloc] initWithTitle:@"Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Cancel Call Service" otherButtonTitles:@"Resubmit Call Service", nil];
        [sheet showFromBarButtonItem:sender animated:YES];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    HistoryEntry* history=[self.historyManager.histories objectAtIndex:self.selectedIndex];
    RequestStatus status=history.status;
    
    BOOL create_request=NO;
    BOOL delete_request=NO;
    self.newStatus=status;
    if(status==requestSubmitted)
    {
        if(buttonIndex==0)
        {
            self.newStatus=requestCompleted;
            delete_request=YES;
        }
        else if(buttonIndex==1) 
        {
            self.newStatus=requestCancel;
            delete_request=YES;
        }
    }
    else if(status==requestCancel)
    {
        if(buttonIndex==0)
        {
            self.newStatus=requestCompleted;
        }
        else if(buttonIndex==1) 
        {
            self.newStatus=requestSubmitted;
            create_request=YES;
        }
    }
    else if(status==requestCompleted)
    {
        if(buttonIndex==0)
        {
            self.newStatus=requestCancel;
        }
        else if(buttonIndex==1) 
        {
            self.newStatus=requestSubmitted;
            create_request=YES;
        }
    }
    
    if(create_request)
    {
        self.data = [NSMutableData data];
        
        NSMutableURLRequest *request = [NSMutableURLRequest 
                                        requestWithURL:[NSURL URLWithString:@"http://www.czcodezone.com/aas/app/submit_request.php"]];
        
        NSString *params = [self createRequest:history];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        self.connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    }
    
    if(delete_request)
    {
        self.data = [NSMutableData data];
        
        NSMutableURLRequest *request = [NSMutableURLRequest 
                                        requestWithURL:[NSURL URLWithString:@"http://www.czcodezone.com/aas/app/delete_request.php"]];
        
        NSString *params = [self deleteRequest:history];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        self.connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
    [self.data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)d 
{
    [self.data appendData:d];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    HistoryEntry* history=[self.historyManager.histories objectAtIndex:self.selectedIndex];
    self.newStatus=history.status;
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"")
                                message:[error localizedDescription]
                               delegate:nil
                      cancelButtonTitle:NSLocalizedString(@"OK", @"") 
                      otherButtonTitles:nil] show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    NSString *responseText = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    
    HistoryEntry* history=[self.historyManager.histories objectAtIndex:self.selectedIndex];
    history.status=self.newStatus;
    [self.historyManager notifyIndividualChange:self.selectedIndex];
    [self.historyManager saveToDisk];
    
    NSString* status=@"Submitted";
    if(history.status==requestCompleted)
    {
        status=@"Completed";
    }
    else if(history.status==requestCancel)
    {
        status=@"Canceled";
    }
    self.statusField.text=status;

    
    //NSString* filepath=[NSHomeDirectory() stringByAppendingPathComponent: [NSString stringWithFormat: @"Documents/%@", @"test.txt"]];
    
    //[responseText writeToFile:filepath atomically:YES encoding: kCFStringEncodingUTF8 error:nil];
    
    //NSLog(@"%@", responseText);
    
    // Do anything you want with it 
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Call  Status Updated!" message:responseText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
    
}

// Handle basic authentication challenge if needed
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge 
{
    NSString *username = @"username";
    NSString *password = @"password";
    
    NSURLCredential *credential = [NSURLCredential credentialWithUser:username
                                                             password:password
                                                          persistence:NSURLCredentialPersistenceForSession];
    [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
}

- (NSString*) createRequest:(HistoryEntry*)history 
{
    NSMutableString* request=[NSMutableString string];
    
    int status=0;
    
    [request appendFormat:@"id=%@", [history.identifier urlEncode]];
    [request appendFormat:@"&userId=%@", [history.userId urlEncode]];
    
    [request appendFormat:@"&idType=%d", history.idType];
    [request appendFormat:@"&name=%@", [history.name urlEncode]];
    [request appendFormat:@"&contactNumber=%@", [history.contactNumber urlEncode]];
    [request appendFormat:@"&carMake=%@", [history.carMake urlEncode]];
    [request appendFormat:@"&carModel=%@", [history.carModel urlEncode]];
    [request appendFormat:@"&carColor=%@", [history.carColor urlEncode]];
    [request appendFormat:@"&carNumber=%@", [history.carNumber urlEncode]];
    [request appendFormat:@"&lat=%lf", history.lat];
    [request appendFormat:@"&lng=%lf", history.lng];
    [request appendFormat:@"&address=%@", [history.address urlEncode]];
    [request appendFormat:@"&note=%@", [history.note urlEncode]];
    [request appendFormat:@"&status=%d", status];
    [request appendFormat:@"&comment=%@", @"submitted"];
    
    return request;
}

- (NSString*) deleteRequest:(HistoryEntry*)history 
{
    NSMutableString* request=[NSMutableString string];
    
    [request appendFormat:@"id=%@", [history.identifier urlEncode]];
      
    return request;
}
@end
