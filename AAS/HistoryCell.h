//
//  ArtCell.h
//  NPRender
//
//  Created by Chen Xianshun on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HistoryEntry;

@interface HistoryCell : UITableViewCell
@property(nonatomic, strong) IBOutlet UILabel* noteLabel;
@property(nonatomic, strong) IBOutlet UILabel* dateLabel;
@property(nonatomic, strong) IBOutlet UILabel* addressLabel;
@property(nonatomic, strong) IBOutlet UIImageView* imgLabel;
@property(nonatomic, strong) IBOutlet UIImageView* imgOrig;
@property(nonatomic, strong) IBOutlet UILabel* statusLabel;

-(void) configureWithHistoryEntry: (HistoryEntry*) photo;
-(void) configure;
@end
