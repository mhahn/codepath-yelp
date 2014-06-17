//
//  FilterValue.m
//  Yelp
//
//  Created by mhahn on 6/17/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import "FilterValue.h"

@implementation FilterValue

- (id)initWithIdentifier:(NSString *)identifier label:(NSString *)label enabled:(BOOL)enabled {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _label = label;
        _enabled = enabled;
    }
    return self;
}

+ (NSArray *)buildFilterValuesWithArrayOfDictionaries:(NSArray *)rawFilterValues {
    NSArray *filterValues = [[NSArray alloc] init];
    for (NSDictionary *filterDict in rawFilterValues) {
        FilterValue *filter = [[FilterValue alloc] initWithIdentifier:filterDict[@"id"] label:filterDict[@"label"] enabled:[filterDict[@"enabled"] boolValue]];
        filterValues = [filterValues arrayByAddingObject:filter];
    }
    return filterValues;
}

@end
