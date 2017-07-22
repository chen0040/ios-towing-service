//
//  MasterModeViewController.m
//  AAS
//
//  Created by Chen Xianshun on 24/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterModeViewController.h"

@interface MasterModeViewController ()

@end

@implementation MasterModeViewController
@synthesize data=_data;
@synthesize connection=_connection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doRemoveAllCompletedRequests:(id)sender 
{
    self.data = [NSMutableData data];
    
    NSMutableURLRequest *request = [NSMutableURLRequest 
                                    requestWithURL:[NSURL URLWithString:@"http://www.czcodezone.com/aas/app/remove_requests.php"]];
    
    NSString *params = @"status=1";
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    self.connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
}

- (IBAction)doRemoveAllSubmittedRequests:(id)sender {
    self.data = [NSMutableData data];
    
    NSMutableURLRequest *request = [NSMutableURLRequest 
                                    requestWithURL:[NSURL URLWithString:@"http://www.czcodezone.com/aas/app/remove_requests.php"]];
    
    NSString *params = @"status=0";
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    self.connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
}

- (IBAction)doRemoveAllCancelledRequests:(id)sender {
    self.data = [NSMutableData data];
    
    NSMutableURLRequest *request = [NSMutableURLRequest 
                                    requestWithURL:[NSURL URLWithString:@"http://www.czcodezone.com/aas/app/remove_requests.php"]];
    
    NSString *params = @"status=2";
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    self.connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
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
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Requests Removed!" message:responseText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
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
@end
