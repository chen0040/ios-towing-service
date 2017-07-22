//
//  AccInfo.m
//  AAS
//
//  Created by Chen Xianshun on 20/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AccInfo.h"
#import "DDXML.h"

@implementation AccInfo
@synthesize userId=_userId;
@synthesize idType=_idType;
@synthesize name=_name;
@synthesize contactNumber=_contactNumber;
@synthesize carMake=_carMake;
@synthesize carColor=_carColor;
@synthesize carModel=_carModel;
@synthesize carNumber=_carNumber;

-(id) initWithUserId:(NSString *)userId andName:(NSString *)name andIdType:(IDType)idType andContactNumber:(NSString *)contactNumber andCarMake:(NSString *)carMake andCarColor:(NSString *)color andCarModel:(NSString *)carModel andCarNumber:(NSString *)carNumber
{
    self=[super init];
    if(self)
    {
        _userId=userId;
        _name=name;
        _idType=idType;
        _contactNumber=contactNumber;
        _carModel=carModel;
        _carMake=carMake;
        _carColor=color;
        _carNumber=carNumber;
    }
    
    return self;
}

-(id) init
{
    self=[super init];
    if(self)
    {
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
                    NSString* p_userId=[[level1 attributeForName:@"userId"] stringValue];
                    NSString* p_name=[[level1 attributeForName:@"name"] stringValue];
                    NSString* p_idType=[[level1 attributeForName:@"idType"] stringValue];
                    NSString* p_contactNumber=[[level1 attributeForName:@"contactNumber"] stringValue];
                    NSString* p_carMake=[[level1 attributeForName:@"carMake"] stringValue];
                    NSString* p_carModel=[[level1 attributeForName:@"carModel"] stringValue];
                    NSString* p_carColor=[[level1 attributeForName:@"carColor"] stringValue];
                    NSString* p_carNumber=[[level1 attributeForName:@"carNumber"] stringValue];
                    
                    int idType=[p_idType intValue];
                    
                    _userId=p_userId;
                    _name=p_name;
                    _idType=idType;
                    _contactNumber=p_contactNumber;
                    _carMake=p_carMake;
                    _carModel=p_carModel;
                    _carColor=p_carColor;
                    _carNumber=p_carNumber;
                }
            }
        }
        else {
            _userId=@"";
            _name=@"";
            _idType=NRIC;
            _contactNumber=@"";
            _carColor=@"Black";
            _carModel=@"";
            _carMake=@"";
            _carNumber=@"";
        }
    }
    return self;
}

-(NSString*) filePath
{
    NSString* filepath=[NSHomeDirectory() stringByAppendingPathComponent: [NSString stringWithFormat: @"Documents/%@", @"accInfo.xml"]];
    return filepath;
}

-(void) saveToDisk
{
    NSString* fpath=[self filePath];
    
    NSError* error;
    
    DDXMLDocument* doc=[[DDXMLDocument alloc] initWithXMLString:@"<?xml version=\"1.0\"?><acc></acc>" options:0 error:&error];
    if(error)
    {
        return;
    }
    DDXMLElement* doc_root=[doc rootElement];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy_MM_dd_hh_mm_ss"];
    
    DDXMLElement* level1=[DDXMLElement elementWithName:@"p"];
        
    DDXMLNode* p_userId=[DDXMLNode attributeWithName:@"userId" stringValue:self.userId];
    [level1 addAttribute:p_userId];
        
    DDXMLNode* p_idType=[DDXMLNode attributeWithName:@"idType" stringValue:[NSString stringWithFormat: @"%d", (int)self.idType]];
    [level1 addAttribute:p_idType];
    
    DDXMLNode* p_name=[DDXMLNode attributeWithName:@"name" stringValue:self.name];
    [level1 addAttribute:p_name];
        
    DDXMLNode* p_contactNumber=[DDXMLNode attributeWithName:@"contactNumber" stringValue:self.contactNumber];
    [level1 addAttribute:p_contactNumber];
        
    DDXMLNode* p_carMake=[DDXMLNode attributeWithName:@"carMake" stringValue:self.carMake];
    [level1 addAttribute:p_carMake];
        
    DDXMLNode* p_carModel=[DDXMLNode attributeWithName:@"carModel" stringValue:self.carModel];
    [level1 addAttribute:p_carModel];
        
    DDXMLNode* p_carColor=[DDXMLNode attributeWithName:@"carColor" stringValue:self.carColor];
    [level1 addAttribute:p_carColor];
    
    DDXMLNode* p_carNumber=[DDXMLNode attributeWithName:@"carNumber" stringValue:self.carNumber];
    [level1 addAttribute:p_carNumber];
        
    [doc_root addChild:level1];
    
    NSData* data = [doc XMLData];
    [data writeToFile:fpath atomically:NO];
}


@end
