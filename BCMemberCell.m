//
//  BCMemberCell.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/10/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCMemberCell.h"

@implementation BCMemberCell

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

@end
