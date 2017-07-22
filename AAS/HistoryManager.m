//
//  HistoryManager.m
//  NPRender
//
//  Created by Chen Xianshun on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HistoryManager.h"
#import "HistoryEntry.h"
#import "DDXML.h"

static NSString* NotificationNameHistoryChange=@"HistoryChangeNotification";

@interface HistoryManager()
@property(nonatomic, strong) NSMutableArray* historyArchive;
@end

@implementation HistoryManager
@synthesize historyArchive = _historyArchive;

+(NSSet*)keyPathsForValuesAffectingHistories{
    return [NSSet setWithObjects:@"historyArchive", nil];
}

-(NSArray*)histories
{
    return self.historyArchive;
}

-(id)init
{
    self=[super init];
    if(self)
    {
        _historyArchive=[[NSMutableArray alloc] init];
        
        NSString* fpath=[self filePath];
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:fpath];
        
        if(fileExists)
        {
            NSError* error;
            NSString* content=[NSString stringWithContentsOfFile:fpath encoding:NSUTF8StringEncoding error:&error];
            if(error)
            {
                NSLog(@"Error: %@", [error localizedDescription]);
                return self;
            }
            DDXMLDocument* doc=[[DDXMLDocument alloc] initWithXMLString:content options:0 error:&error];
            if(error)
            {
                NSLog(@"Error: %@", [error localizedDescription]);
                return self;
            }
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
            [dateFormatter setDateFormat:@"yyyy_MM_dd_hh_mm_ss"];
            
            DDXMLElement* doc_root=[doc rootElement];
            NSArray* doc_root_children=[doc_root children];
            for(id level1 in doc_root_children)
            {
                if([[level1 name] isEqualToString:@"p"])
                {
                    NSString* p_id = [[level1 attributeForName:@"id"] stringValue];
                    NSString* p_note = [[level1 attributeForName:@"note"] stringValue];
                    NSString* p_address = [[level1 attributeForName:@"address"] stringValue];
                    NSString* p_lat=[[level1 attributeForName:@"lat"] stringValue];
                    NSString* p_lng=[[level1 attributeForName:@"lng"] stringValue];
                    NSString* p_date =[[level1 attributeForName:@"date"] stringValue];
                    NSString* p_userId=[[level1 attributeForName:@"userId"] stringValue];
                    NSString* p_name=[[level1 attributeForName:@"name"] stringValue];
                    NSString* p_idType=[[level1 attributeForName:@"idType"] stringValue];
                    NSString* p_contactNumber=[[level1 attributeForName:@"contactNumber"] stringValue];
                    NSString* p_carMake=[[level1 attributeForName:@"carMake"] stringValue];
                    NSString* p_carModel=[[level1 attributeForName:@"carModel"] stringValue];
                    NSString* p_carColor=[[level1 attributeForName:@"carColor"] stringValue];
                    NSString* p_carNumber=[[level1 attributeForName:@"carNumber"] stringValue];
                    NSString* p_status=[[level1 attributeForName:@"status"] stringValue];
                    
                    CGFloat lat=[p_lat floatValue];
                    CGFloat lng=[p_lng floatValue];
                    int idType=[p_idType intValue];
                    int status=[p_status intValue];
                    
                    HistoryEntry* npr=[[HistoryEntry alloc] initWithUserId:p_userId andName:p_name andIdType:idType andContactNumber:p_contactNumber andCarMake:p_carMake andCarColor:p_carColor andCarModel:p_carModel andCarNumber: p_carNumber andDate: [dateFormatter dateFromString:p_date] andIdentifier: p_id andAddress: p_address andNote: p_note andLat: lat andLng: lng andStatus:status];
                    [self.historyArchive addObject:npr];
                }
            }
        }

    }
    return self;
}

-(void)addHistory:(HistoryEntry *)entry
{
    [self willChange: NSKeyValueChangeInsertion valuesAtIndexes:[NSIndexSet indexSetWithIndex:0] forKey:KVOHistoryChangeKey];
    [self.historyArchive insertObject:entry atIndex:0];
    [self didChange: NSKeyValueChangeInsertion valuesAtIndexes:[NSIndexSet indexSetWithIndex:0] forKey: KVOHistoryChangeKey];
    [self saveToDisk];
}

-(void)removeHistoryAtIndex:(NSUInteger)historyIndex
{
    [self willChange: NSKeyValueChangeRemoval valuesAtIndexes: [NSIndexSet indexSetWithIndex: historyIndex] forKey:KVOHistoryChangeKey];
    [self.historyArchive removeObjectAtIndex:historyIndex];
    [self didChange: NSKeyValueChangeRemoval valuesAtIndexes:[NSIndexSet indexSetWithIndex:historyIndex] forKey:KVOHistoryChangeKey];
    [self saveToDisk];
}

-(NSString*) filePath
{
    NSString* filepath=[NSHomeDirectory() stringByAppendingPathComponent: [NSString stringWithFormat: @"Documents/%@", @"historyArchive.xml"]];
    return filepath;
    
}

-(void) saveToDisk
{
    NSString* fpath=[self filePath];
    
    NSError* error;
    
    DDXMLDocument* doc=[[DDXMLDocument alloc] initWithXMLString:@"<?xml version=\"1.0\"?><histories></histories>" options:0 error:&error];
    if(error)
    {
        return;
    }
    DDXMLElement* doc_root=[doc rootElement];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy_MM_dd_hh_mm_ss"];
    
    
    
    int count=self.historyArchive.count;
    for(int i=0; i < count; ++i)
    {
        HistoryEntry* npr=[self.historyArchive objectAtIndex:i];
        DDXMLElement* level1=[DDXMLElement elementWithName:@"p"];
        
        
        DDXMLNode* p_id=[DDXMLNode attributeWithName:@"id" stringValue:npr.identifier];
        [level1 addAttribute:p_id];
        
        DDXMLNode* p_address=[DDXMLNode attributeWithName:@"address" stringValue:npr.address];
        [level1 addAttribute:p_address];
        
        DDXMLNode* p_note=[DDXMLNode attributeWithName:@"note" stringValue:npr.note];
        [level1 addAttribute:p_note];
        
        NSString* pstr_date =[dateFormatter stringFromDate:npr.date];
        
        DDXMLNode* p_date=[DDXMLNode attributeWithName:@"date" stringValue:pstr_date];
        [level1 addAttribute:p_date];
        
        DDXMLNode* p_lat=[DDXMLNode attributeWithName:@"lat" stringValue: [NSString stringWithFormat:@"%lf", npr.lat]];
        [level1 addAttribute:p_lat];
        
        DDXMLNode* p_lng=[DDXMLNode attributeWithName:@"lng" stringValue: [NSString stringWithFormat:@"%lf", npr.lng]];
        [level1 addAttribute:p_lng];
        
        DDXMLNode* p_userId=[DDXMLNode attributeWithName:@"userId" stringValue:npr.userId];
        [level1 addAttribute:p_userId];
        
        DDXMLNode* p_name=[DDXMLNode attributeWithName:@"name" stringValue:npr.name];
        [level1 addAttribute:p_name];
        
        DDXMLNode* p_idType=[DDXMLNode attributeWithName:@"idType" stringValue:[NSString stringWithFormat: @"%d", (int)npr.idType]];
        [level1 addAttribute:p_idType];
        
        DDXMLNode* p_contactNumber=[DDXMLNode attributeWithName:@"contactNumber" stringValue:npr.contactNumber];
        [level1 addAttribute:p_contactNumber];
        
        DDXMLNode* p_carMake=[DDXMLNode attributeWithName:@"carMake" stringValue:npr.carMake];
        [level1 addAttribute:p_carMake];
        
        DDXMLNode* p_carModel=[DDXMLNode attributeWithName:@"carModel" stringValue:npr.carModel];
        [level1 addAttribute:p_carModel];
        
        DDXMLNode* p_carColor=[DDXMLNode attributeWithName:@"carColor" stringValue:npr.carColor];
        [level1 addAttribute:p_carColor];
        
        DDXMLNode* p_carNumber=[DDXMLNode attributeWithName:@"carNumber" stringValue:npr.carNumber];
        [level1 addAttribute:p_carNumber];
        
        DDXMLNode* p_status=[DDXMLNode attributeWithName:@"status" stringValue:[NSString stringWithFormat:@"%d", (int)npr.status]];
        [level1 addAttribute:p_status];
        
        [doc_root addChild:level1];
    }
    
    NSData* data = [doc XMLData];
    [data writeToFile:fpath atomically:NO];
}

-(void) notifyIndividualChange: (NSUInteger) objIndex
{
    NSNotificationCenter* nc=[NSNotificationCenter defaultCenter];
    [nc postNotificationName:NotificationNameHistoryChange object:[NSNumber numberWithUnsignedInteger:objIndex]];
}
@end
