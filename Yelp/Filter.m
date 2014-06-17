//
//  Filter.m
//  Yelp
//
//  Created by mhahn on 6/17/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import "Filter.h"

@implementation Filter

- (id)initWithIdentifier:(NSString *)identifier label:(NSString *)label filterValues:(NSArray *)filterValues isCollapsable:(BOOL)isCollapsable isCollapsed:(BOOL)isCollapsed selectedRow:(int)selectedRow {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _label = label;
        _filterValues = filterValues;
        _isCollapsable = isCollapsable;
        _isCollapsed = isCollapsed;
        _selectedRow = selectedRow;
    }
    return self;
}

- (void)toggleCollapsed:(int)selectedRow {
    if (_isCollapsable) {
        _isCollapsed = !_isCollapsed;
        _selectedRow = selectedRow;
    }
}
@end
