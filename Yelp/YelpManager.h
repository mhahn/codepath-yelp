//
//  YelpManager.h
//  Yelp
//
//  Created by mhahn on 6/16/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ReactiveCocoa.h>

#import "FilterGroup.h"
#import "Restaurant.h"

@interface YelpManager : NSObject

@property (nonatomic, strong) NSString *currentSearchTerm;
@property (nonatomic, strong) NSArray *currentRestaurants;
@property (nonatomic, strong) NSArray *filterGroups;

+ (instancetype)sharedManager;

- (RACSignal *)fetchRestaurantsWithTerm:(NSString *)term;
- (FilterGroup *)getFilterGroupForSection:(int)section;

@end
