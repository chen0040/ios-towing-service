//
//  DataOnlineViewController.m
//  AAS
//
//  Created by Chen Xianshun on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataOnlineViewController.h"
#import "AccInfo.h"
#import "HistoryManager.h"

@interface DataOnlineViewController ()

@end

@implementation DataOnlineViewController
@synthesize account=_account;
@synthesize myWebView = _myWebView;
@synthesize historyManager=_historyManager;

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
    
    NSString *urlAddress = @"http://www.czcodezone.com/odata/app/map";
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    self.myWebView.delegate=self;
    //Load the request in the UIWebView.
    [self.myWebView loadRequest:requestObj];
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

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


@end
