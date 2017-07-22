//
//  AddressAnnotation.m
//  AAS
//
//  Created by Chen Xianshun on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddressAnnotation.h"

@implementation AddressAnnotation
@synthesize title=_title;
@synthesize subtitle=_subtitle;
@synthesize coordinate=_coordinate;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
    coordinate=c;
    NSLog(@"%f,%f",c.latitude,c.longitude);
    return self;
}
@end