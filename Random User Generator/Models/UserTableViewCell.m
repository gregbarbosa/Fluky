//
//  UserTableViewCell.m
//  Random User Generator
//
//  Created by Greg Barbosa on 1/30/14.
//  Copyright (c) 2014 PolaritySoftware. All rights reserved.
//

#import "UserTableViewCell.h"

@implementation UserTableViewCell

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

- (void) layoutSubviews {
    [super layoutSubviews];
    self.imageView.bounds = CGRectMake(0,0,70,70);
    self.imageView.layer.cornerRadius = 70/2;
    self.imageView.layer.masksToBounds = true;
}
@end
