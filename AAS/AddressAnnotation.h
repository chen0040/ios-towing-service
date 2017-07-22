//
//  AddressAnnotation.h
//  AAS
//
//  Created by Chen Xianshun on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface AddressAnnotation : NSObject<MKAnnotation> {
    CLLocationCoordinate2D coordinate; 
    NSString *title;
    NSString *subtitle;
}
@property(nonatomic, copy) NSString* title;
@property(nonatomic, copy) NSString* subtitle;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate; 
@end

