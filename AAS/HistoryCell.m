//
//  ArtCell.m
//  NPRender
//
//  Created by Chen Xianshun on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HistoryCell.h"
#import "HistoryEntry.h"

@implementation HistoryCell
@synthesize noteLabel = _noteLabel;
@synthesize dateLabel = _dateLabel;
@synthesize addressLabel=_addressLabel;
@synthesize imgLabel=_imgLabel;
@synthesize imgOrig=_imgOrig;
@synthesize statusLabel=_statusLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void) configureWithHistoryEntry:(HistoryEntry *)history
{
    self.noteLabel.text=history.note;
    self.addressLabel.text=history.address;
    
    self.dateLabel.text=[NSDateFormatter localizedStringFromDate:history.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    
    NSString* status=@"Submitted";
    if(history.status==requestCompleted)
    {
        status=@"Completed";
        self.statusLabel.textColor=[UIColor blueColor];
        self.imgLabel.image=[UIImage imageNamed:@"completed.png"];
    }
    else if(history.status==requestCancel)
    {
        status=@"Canceled";
        self.statusLabel.textColor=[UIColor darkGrayColor];
        self.imgLabel.image=[UIImage imageNamed:@"canceled.png"];
    }
    else {
        self.statusLabel.textColor=[UIColor redColor];
        self.imgLabel.image=[UIImage imageNamed:@"submitted.png"];
    }
    self.statusLabel.text=status;
    
    //self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"book_row.png"]];
    self.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"book_row.png"]];
}

-(void) configure
{
    self.noteLabel.text=nil;
    self.dateLabel.text=nil;
    self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"book_row.png"]];
}


@end
