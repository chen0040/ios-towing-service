//
//  ArtEntry.h
//  NPRender
//
//  Created by Chen Xianshun on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccInfo.h"

typedef enum
{
    requestSubmitted,
    requestCompleted,
    requestCancel
} RequestStatus;

@interface HistoryEntry : AccInfo
@property(nonatomic, strong, readonly) NSString* identifier;
@property(nonatomic, strong, readonly) NSDate* date;
@property(nonatomic, strong, readonly) NSString* address;
@property(nonatomic, strong, readwrite) NSString* note;
@property(nonatomic, assign, readonly) CGFloat lat;
@property(nonatomic, assign, readonly) CGFloat lng;
@property(nonatomic, assign, readwrite) RequestStatus status;

-(id) initWithUserId:(NSString *)userId andName:(NSString *)name andIdType:(IDType)idType andContactNumber:(NSString *)contactNumber andCarMake:(NSString *)carMake andCarColor:(NSString *)color andCarModel:(NSString *)carModel andCarNumber: (NSString*)carNumber andDate: (NSDate*)date andIdentifier: (NSString*)identifier andAddress: (NSString*)address andNote: (NSString*)note andLat: (CGFloat)lat andLng: (CGFloat)lng andStatus: (RequestStatus)status;

-(id) initWithUserId:(NSString *)userId andName:(NSString *)name andIdType:(IDType)idType andContactNumber:(NSString *)contactNumber andCarMake:(NSString *)carMake andCarColor:(NSString *)color andCarModel:(NSString *)carModel andCarNumber: (NSString*) carNumber andAddress: (NSString*)address andNote: (NSString*)note andLat: (CGFloat)lat andLng: (CGFloat)lng andStatus: (RequestStatus)status;

-(id) initWithAcc: (AccInfo*)acc andAddress: (NSString*)address andNote: (NSString*)note andLat: (CGFloat)lat andLng: (CGFloat)lng;

@end
