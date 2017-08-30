//
//  SpinnerTableViewCell.m
//  tvSchedules
//
//  Created by Tik on 30/8/17.
//  Copyright © 2017 tipayanond. All rights reserved.
//

#import "SpinnerTableViewCell.h"

@implementation SpinnerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.spinnerView startAnimating];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
