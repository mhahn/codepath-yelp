//
//  YelpManager.h
//  Yelp
//
//  Created by mhahn on 6/16/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ReactiveCocoa.h>

#import "Restaurant.h"

@interface YelpManager : NSObject

@property (nonatomic, strong) NSString *currentSearchTerm;
@property (nonatomic, strong) NSArray *currentRestaurants;

+ (instancetype)sharedManager;

- (RACSignal *)fetchRestaurantsWithTerm:(NSString *)term;

@end
