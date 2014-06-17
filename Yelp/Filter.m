//
//  FilterValue.m
//  Yelp
//
//  Created by mhahn on 6/17/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import "Filter.h"

@implementation Filter

- (id)initWithIdentifier:(NSString *)identifier label:(NSString *)label enabled:(BOOL)enabled apiValue:(NSString *)apiValue {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _label = label;
        _enabled = enabled;
        _apiValue = apiValue;
    }
    return self;
}

+ (NSArray *)buildFilterValuesWithArrayOfDictionaries:(NSArray *)rawFilterValues {
    NSArray *filterValues = [[NSArray alloc] init];
    for (NSDictionary *filterDict in rawFilterValues) {
        Filter *filter = [[Filter alloc] initWithIdentifier:filterDict[@"id"] label:filterDict[@"label"] enabled:[filterDict[@"enabled"] boolValue] apiValue:filterDict[@"api_value"]];
        filterValues = [filterValues arrayByAddingObject:filter];
    }
    return filterValues;
}

@end
