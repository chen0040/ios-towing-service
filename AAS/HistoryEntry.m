//
//  ArtEntry.m
//  NPRender
//
//  Created by Chen Xianshun on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HistoryEntry.h"

@implementation HistoryEntry
@synthesize identifier = _identifier;
@synthesize date = _date;
@synthesize address = _address;
@synthesize note = _note;
@synthesize lat=_lat;
@synthesize lng=_lng;
@synthesize status=_status;

-(id) initWithUserId:(NSString *)userId andName:(NSString *)name andIdType:(IDType)idType andContactNumber:(NSString *)contactNumber andCarMake:(NSString *)carMake andCarColor:(NSString *)color andCarModel:(NSString *)carModel andCarNumber: (NSString*)carNumber andDate:(NSDate *)date andIdentifier:(NSString*)identifier andAddress:(NSString *)address andNote:(NSString *)note andLat:(CGFloat)lat andLng:(CGFloat)lng andStatus:(RequestStatus)status
{
    self=[super initWithUserId:userId andName:name andIdType:idType andContactNumber:contactNumber andCarMake:carMake andCarColor:color andCarModel:carModel andCarNumber:carNumber];
    if(self)
    {
        _identifier=identifier;
        _address=address;
        _date=date;
        _lat=lat;
        _lng=lng;
        _note=note;
        _status=status;
    }
    return self;
}

-(id) initWithUserId:(NSString *)userId andName:(NSString *)name andIdType:(IDType)idType andContactNumber:(NSString *)contactNumber andCarMake:(NSString *)carMake andCarColor:(NSString *)color andCarModel:(NSString *)carModel andCarNumber: (NSString*)carNumber andAddress:(NSString *)address andNote:(NSString *)note andLat:(CGFloat)lat andLng:(CGFloat)lng andStatus: (RequestStatus)status
{
    NSDate* today=[NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy_MM_dd_hh_mm_ss"];
    NSString* identifier=[dateFormatter stringFromDate:today];

    return [self initWithUserId:userId andName:name andIdType:idType andContactNumber:contactNumber andCarMake:carMake andCarColor:color andCarModel:carModel andCarNumber: carNumber andDate: today andIdentifier: identifier andAddress:address andNote:note andLat:lat andLng:lng andStatus: status];
}

-(id) initWithAcc: (AccInfo*)acc andAddress: (NSString*)address andNote: (NSString*)note andLat: (CGFloat)lat andLng: (CGFloat)lng
{
    return [self initWithUserId:acc.userId andName:acc.name andIdType:acc.idType andContactNumber:acc.contactNumber andCarMake:acc.carMake andCarColor:acc.carColor andCarModel:acc.carModel andCarNumber:acc.carNumber andAddress:address andNote:note andLat:lat andLng:lng andStatus:requestSubmitted];
}
@end
