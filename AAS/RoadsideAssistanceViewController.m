//
//  RoadsideAssistanceViewController.m
//  AAS
//
//  Created by Chen Xianshun on 20/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RoadsideAssistanceViewController.h"
#import "AccInfo.h"
#import "HistoryManager.h"
#import "HistoryEntry.h"
#import "NSString+URLEncoding.h"

#define ARC4RANDOM_MAX      0x100000000

@interface RoadsideAssistanceViewController ()

@end

@implementation RoadsideAssistanceViewController
@synthesize breakdownLocationField = _breakdownLocationField;
@synthesize noteField = _noteField;
@synthesize account=_account;
@synthesize historyManager=_historyManager;
@synthesize currentLocation=_currentLocation;
@synthesize reportLocation=_reportLocation;
@synthesize data=_data;
@synthesize connection=_connection;
@synthesize currentRequest=_currentRequest;

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
    
    if(!locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    // Set Location Manager delegate
    [locationManager setDelegate:self];
    
    // Set location accuracy levels
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    // Update again when a user moves distance in meters
    [locationManager setDistanceFilter:5];
    
    // Configure permission dialog
    [locationManager setPurpose:@"Geo Location Enable"];
    
    // Start updating location
    [locationManager startUpdatingLocation];
}

- (void)viewDidUnload
{
    [self setBreakdownLocationField:nil];
    [self setNoteField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - CoreLocation Delegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    
    NSLog(@"%@",[newHeading description]);
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    // The user moved, update the map and print info to the on view textview
    //[mapView setCenterCoordinate:newLocation.coordinate animated:YES];
    //[textView setText:[NSString stringWithFormat:@"%@\n%@",[newLocation description],textView.text]];
    
    self.currentLocation=newLocation;
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"Entered Region");
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"Exited Region");
}

- (void) showAlert: (NSString*)msg
{
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Input Invalid!" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)doSubmit:(id)sender 
{
    if([self.breakdownLocationField.text isEqualToString:@""])
    {
        return;
    }
    if([self.noteField.text isEqualToString:@""])
    {
        return;
    }
    
    CLLocationCoordinate2D coord=self.reportLocation.coordinate;
    
    HistoryEntry* history=[[HistoryEntry alloc] initWithAcc:self.account andAddress:self.breakdownLocationField.text andNote:self.noteField.text andLat:coord.latitude andLng:coord.longitude];
    
    [self.historyManager addHistory:history];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    self.data = [NSMutableData data];
    
    NSMutableURLRequest *request = [NSMutableURLRequest 
									requestWithURL:[NSURL URLWithString:@"http://www.czcodezone.com/aas/app/submit_request.php"]];
    
    NSString *params = [self createSubmitRequest:history];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    self.connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
}

- (NSString*) createSubmitRequest:(HistoryEntry*)history
{
    NSMutableString* request=[NSMutableString string];
    
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
    [request appendFormat:@"&status=%d", history.status];
    //[[NSString alloc] initWithFormat:@"foo=bar&key=value"];
    
    return request;
}

- (IBAction)doGetAddress:(id)sender 
{
    // Reverse Geocode the new location to a human readable address
    CLGeocoder *rgeo = [[CLGeocoder alloc] init];
    [rgeo reverseGeocodeLocation:self.reportLocation 
               completionHandler:^(NSArray *placemarks, NSError *error){
                   
                   // Make sure the geocoder did not produce an error
                   // before coninuing
                   if(!error){
                       
                       // Iterate through all of the placemarks returned
                       // and output them to the console
                       /*
                        for(CLPlacemark *placemark in placemarks){
                        NSLog(@"%@",[placemark description]);  
                        }*/
                       self.breakdownLocationField.text=[[placemarks objectAtIndex:0] description];
                   }
                   else{
                       // Our geocoder had an error, output a message
                       // to the console
                       NSLog(@"There was a forward geocoding error\n%@",
                             [error localizedDescription]);
                   }           
               }];
}

- (IBAction)doClear:(id)sender 
{
    self.noteField.text=@"";
}

- (IBAction)doDummyChoose:(id)sender 
{
    UIActionSheet* sheet=[[UIActionSheet alloc] initWithTitle:@"Choose Location to Report" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Current" otherButtonTitles:@"Dummy: SouthWest", @"Dummy: SouthEast", @"Dummay: NorthWest", @"Dummy: NorthEast", @"Dummy: Wander", nil];
    
    [sheet showInView:self.view];
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
    
    //NSString* filepath=[NSHomeDirectory() stringByAppendingPathComponent: [NSString stringWithFormat: @"Documents/%@", @"test.txt"]];
    
    //[responseText writeToFile:filepath atomically:YES encoding: kCFStringEncodingUTF8 error:nil];
    
    //NSLog(@"%@", responseText);
    
    // Do anything you want with it 
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Call Submitted" message:responseText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
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

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        self.reportLocation=self.currentLocation;
    }
    else {
        CGFloat min_lat=1.2427, min_lng=103.6271, max_lat=1.4548, max_lng=103.99993;
        CGFloat lat=1.33;
        CGFloat lng=103.8;
        if(buttonIndex==1)
        {
            max_lat=lat;
            max_lng=lng;
        }
        else if(buttonIndex==2)
        {
            max_lat=lat;
            min_lng=lng;
        }
        else if(buttonIndex==3)
        {
            min_lat=lat;
            max_lng=lng;
        }
        else if(buttonIndex==4)
        {
            min_lat=lat;
            min_lng=lng;
        }
        
        double val = ((double)arc4random() / ARC4RANDOM_MAX);
        
        CGFloat rlat=min_lat+val * (max_lat - min_lat);
        
        val = ((double)arc4random() / ARC4RANDOM_MAX);
        
        CGFloat rlng=min_lng+val * (max_lng - min_lng);
        
        self.reportLocation=[[CLLocation alloc] initWithLatitude:rlat longitude:rlng];
        
        //CLLocationCoordinate2DMake(rlat, rlng);
    }
}
@end
