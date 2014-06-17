//
//  YelpManager.m
//  Yelp
//
//  Created by mhahn on 6/16/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import <ReactiveCocoa.h>

#import "Constants.h"
#import "Filter.h"
#import "FilterValue.h"
#import "YelpClient.h"
#import "YelpManager.h"

@interface YelpManager()

@property (nonatomic, strong) YelpClient *client;

- (RACSignal *)updateRestaurantList;

@end

@implementation YelpManager

- (id)init {
    self = [super init];
    if (self) {
        _client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey
                                           consumerSecret:kYelpConsumerSecret
                                              accessToken:kYelpToken
                                             accessSecret:kYelpTokenSecret];
        
        [[[[RACObserve(self, currentSearchTerm) ignore:nil] flattenMap:^(NSString *newTerm) {
            return [self updateRestaurantList];
        }] deliverOn:[RACScheduler mainThreadScheduler]] subscribeError:^(NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        // XXX come up with some better way for initing these
        NSArray *sortByFilterValues = [FilterValue buildFilterValuesWithArrayOfDictionaries:@[
                                                                                              @{@"id": @"best_match", @"enabled": @(NO), @"label": @"Best Match"},
                                                                                              @{@"id": @"distance", @"enabled": @(NO), @"label": @"Distance"},
                                                                                              @{@"id": @"rating", @"enabled": @(NO), @"label": @"Rating"},
                                                                                              @{@"id": @"most_reviewed", @"enabled": @(NO), @"label": @"Most Reviewed"},
                                                                                              ]
                                       ];
        _filters = @[[[Filter alloc] initWithIdentifier:@"sort_by" label:@"Sort By" filterValues:sortByFilterValues isCollapsable:YES isCollapsed:YES selectedRow:0]];

    }
    return self;
}

- (RACSignal *)updateRestaurantList {
    return [[self fetchRestaurantsWithTerm:_currentSearchTerm] doNext:^(NSArray *restaurants) {
        [self setCurrentRestaurants:restaurants];
    }];
}

- (RACSignal *)fetchRestaurantsWithTerm:(NSString *)term {
    NSDictionary *parameters = @{@"term": term, @"location": @"San Francisco"};
    return [[_client fetchJSONFromURL:parameters] map:^(NSDictionary *json) {
        NSError *jsonError = nil;
        NSArray *result = [MTLJSONAdapter modelsOfClass:[Restaurant class]
                               fromJSONArray:json[@"businesses"]
                                       error:&jsonError];
        if (jsonError) {
            NSLog(@"JSON Error: %@", jsonError);
        }
        
        return result;
    }];
}

- (Filter *)getFilterForSection:(int)section {
    return _filters[section];
}

# pragma mark - Class Methods

+ (instancetype)sharedManager {
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

@end
