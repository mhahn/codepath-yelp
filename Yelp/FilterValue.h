//
//  FilterValue.h
//  Yelp
//
//  Created by mhahn on 6/17/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

@interface FilterValue : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *label;
@property (nonatomic) BOOL enabled;

- (id)initWithIdentifier:(NSString *)identifier label:(NSString *)label enabled:(BOOL)enabled;

+ (NSArray *)buildFilterValuesWithArrayOfDictionaries:(NSArray *)rawFilterValues;

@end
