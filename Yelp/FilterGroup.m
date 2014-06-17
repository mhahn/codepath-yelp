//
//  Filter.m
//  Yelp
//
//  Created by mhahn on 6/17/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import "FilterGroup.h"

@implementation FilterGroup

- (id)initWithIdentifier:(NSString *)identifier label:(NSString *)label filters:(NSArray *)filters isCollapsable:(BOOL)isCollapsable isCollapsed:(BOOL)isCollapsed isExpandable:(BOOL)isExpandable selectedRow:(int)selectedRow rowsWhenCollapsed:(int)rowsWhenCollapsed hasMany:(BOOL)hasMany{
    self = [super init];
    if (self) {
        _identifier = identifier;
        _label = label;
        _filters = filters;
        _isCollapsable = isCollapsable;
        _isCollapsed = isCollapsed;
        _isExpandable = isExpandable;
        _selectedRow = selectedRow;
        _rowsWhenCollapsed = rowsWhenCollapsed;
        _hasMany = hasMany;
    }
    return self;
}

- (void)toggleCollapsed:(int)selectedRow {
    if (_isCollapsable) {
        _isCollapsed = !_isCollapsed;
        _selectedRow = selectedRow;
    } else if (_isExpandable && (selectedRow > (_rowsWhenCollapsed - 1))) {
        _isCollapsed = NO;
    }
}

- (Filter *)getCurrentSelection {
    return _filters[_selectedRow];
}

- (int)displayRowsWhenCollapsed {
    int rows = _rowsWhenCollapsed;
    if (_hasMany) {
        rows += 1;
    }
    return rows;
}

@end