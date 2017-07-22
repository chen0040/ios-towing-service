//
//  AccInfo.h
//  AAS
//
//  Created by Chen Xianshun on 20/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    NRIC,
    PASSPORT,
    FIN
} IDType;

@interface AccInfo : NSObject
@property(nonatomic, strong) NSString* userId;
@property(nonatomic, strong) NSString* name;
@property(nonatomic, assign) IDType idType;
@property(nonatomic, strong) NSString* contactNumber;
@property(nonatomic, strong) NSString* carMake;
@property(nonatomic, strong) NSString* carColor;
@property(nonatomic, strong) NSString* carModel;
@property(nonatomic, strong, readonly) NSString* filePath;
@property(nonatomic, strong) NSString* carNumber;

- (id) initWithUserId: (NSString*)userId andName: (NSString*)name andIdType: (IDType)idType andContactNumber: (NSString*)contactNumber andCarMake: (NSString*)carMake andCarColor: (NSString*)color andCarModel:(NSString*)carModel andCarNumber: (NSString*)carNumber;

-(void) saveToDisk;
@end
