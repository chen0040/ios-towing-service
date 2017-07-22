//
//  ServiceMonitorViewController.m
//  AAS
//
//  Created by Chen Xianshun on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServiceMonitorViewController.h"
#import "AccInfo.h"
#import "HistoryManager.h"
#import "AddressAnnotation.h"
#import "HistoryEntry.h"
#import "ServiceDetailViewController.h"

static NSString* PushServiceDetailSegueIdentifier=@"Push Service Detail";

@interface ServiceMonitorViewController ()

@end

@implementation ServiceMonitorViewController
@synthesize account=_account;
@synthesize myMapView = _myMapView;
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
    
    NSInteger history_count=self.historyManager.histories.count;
    
    double lat=1.3667;
    double lng=103.8;
    NSString* title=@"No service currently";
    NSString* text=@"No service at the moment";
    if(history_count!=0)
    {
        HistoryEntry* selected_history=nil;
        for(int i=0; i < history_count; ++i)
        {
            HistoryEntry* history=[self.historyManager.histories objectAtIndex:i];
            if(history.status==requestSubmitted)
            {
                selected_history=history;
                break;
            }
        }
        if(selected_history)
        {
            lat=selected_history.lat;
            lng=selected_history.lng;
            title=selected_history.identifier;
            text=selected_history.note;
        }
    }
    
    [self.myMapView setMapType:MKMapTypeStandard];
    [self.myMapView setZoomEnabled:YES];
    [self.myMapView setScrollEnabled:YES];
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
    region.center.latitude = lat ;
    region.center.longitude = lng;
    region.span.longitudeDelta = 0.08f;
    region.span.latitudeDelta = 0.08f;
    [self.myMapView setRegion:region animated:YES]; 
    
    [self.myMapView setDelegate:self];
    
    AddressAnnotation *ann = [[AddressAnnotation alloc] init]; 
    ann.title = title;
    ann.subtitle = text; 
    ann.coordinate = region.center; 
    [self.myMapView addAnnotation:ann];
}


- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *AnnotationViewID = @"annotationViewID";
    
    MKAnnotationView *annotationView = (MKAnnotationView *)[self.myMapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    if (annotationView == nil)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    
    annotationView.image = [UIImage imageNamed:@"submitted.png"];
    annotationView.annotation = annotation;
    annotationView.canShowCallout = YES;
    
    // now we'll add the right callout button
    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    // customize this line to fit the structure of your code.  basically
    // you just need to find an integer value that matches your object in some way:
    // its index in your array of MKAnnotation items, or an id of some sort, etc
    // 
    // here I'll assume you have an annotation array that is a property of the current
    // class and we just want to store the index of this annotation.
    NSInteger annotationValue = [self.myMapView.annotations indexOfObject:annotation];
    
    // set the tag property of the button to the index
    detailButton.tag = annotationValue;
    
    // tell the button what to do when it gets touched
    [detailButton addTarget:self action:@selector(showDetailView:) forControlEvents:UIControlEventTouchUpInside];
    
    annotationView.rightCalloutAccessoryView = detailButton;
    
    return annotationView;
}

-(IBAction)showDetailView:(UIView*)sender {
    // get the tag value from the sender
    NSInteger selectedIndex = sender.tag;
    AddressAnnotation *selectedObject = [self.myMapView.annotations objectAtIndex:selectedIndex];
    
    [self performSegueWithIdentifier:PushServiceDetailSegueIdentifier sender:selectedObject];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:PushServiceDetailSegueIdentifier])
    {
        ServiceDetailViewController* controller=segue.destinationViewController;
        controller.historyManager=self.historyManager;
        controller.account=self.account;
        AddressAnnotation* aan=(AddressAnnotation*)sender;
        controller.marker_id=aan.title;
    }
}

- (void)viewDidUnload
{
    [self setMyMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

@end
