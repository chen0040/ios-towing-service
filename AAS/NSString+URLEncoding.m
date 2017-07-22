//
//  NSString+URLEncoding.m
//  AAS
//
//  Created by Chen Xianshun on 21/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)
-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                        (__bridge CFStringRef)self, NULL,
                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                 encoding);
}

-(NSString*) urlEncode
{
    return [self urlEncodeUsingEncoding:kCFStringEncodingUTF8];
}

@end
