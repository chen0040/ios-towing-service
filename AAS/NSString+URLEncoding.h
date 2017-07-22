//
//  NSString+URLEncoding.h
//  AAS
//
//  Created by Chen Xianshun on 21/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncoding)
-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;
-(NSString*) urlEncode;
@end
