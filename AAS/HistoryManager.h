//
//  HistoryManager.h
//  NPRender
//
//  Created by Chen Xianshun on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HistoryEntry;
static NSString* const KVOHistoryChangeKey=@"historyArchive";

@interface HistoryManager : NSObject{
    
}

@property(weak, nonatomic, readonly) NSArray* histories;

-(void)addHistory:(HistoryEntry*) entry;
-(void)removeHistoryAtIndex:(NSUInteger) historyIndex;

-(NSString*) filePath;

-(void) saveToDisk;
-(void) notifyIndividualChange: (NSUInteger) objIndex;
@end
