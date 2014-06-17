//
//  FilterTableViewCell.m
//  Yelp
//
//  Created by mhahn on 6/17/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import "FilterTableViewCell.h"

@interface FilterTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *filterLabel;
@property (weak, nonatomic) IBOutlet UISwitch *filterEnabled;

- (void)handleSwitchUpdate;

@end

@implementation FilterTableViewCell

- (void)awakeFromNib {
    [_filterEnabled addTarget:self action:@selector(handleSwitchUpdate) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)handleSwitchUpdate {
    _filter.enabled = !_filter.enabled;
}
- (void)setFilter:(Filter *)filter {
    _filter = filter;
    _filterLabel.text = filter.label;
    _filterEnabled.on = filter.enabled;
}

@end
