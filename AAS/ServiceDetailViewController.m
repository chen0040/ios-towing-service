//
//  ServiceDetailViewController.m
//  AAS
//
//  Created by Chen Xianshun on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServiceDetailViewController.h"

@interface ServiceDetailViewController ()

@end

@implementation ServiceDetailViewController
@synthesize myWebView=_myWebView;
@synthesize account=_account;
@synthesize historyManager=_historyManager;
@synthesize marker_id=_marker_id;

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
    
    NSString *urlAddress = [NSString stringWithFormat:@"http://www.czcodezone.com/aas/app/request_status.php?id=%@", self.marker_id];
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    self.myWebView.delegate=self;
    //Load the request in the UIWebView.
    [self.myWebView loadRequest:requestObj];

}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (void)viewDidUnload
{
    [self setMyWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
