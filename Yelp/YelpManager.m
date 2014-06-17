//
//  YelpManager.m
//  Yelp
//
//  Created by mhahn on 6/16/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import <ReactiveCocoa.h>

#import "Constants.h"
#import "FilterGroup.h"
#import "Filter.h"
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
        
        NSArray *categoryFilters = [Filter buildFilterValuesWithArrayOfDictionaries:@[
                                                                                      @{@"id": @"bakeries", @"enabled": @(NO), @"label": @"Bakeries", @"api_value": @"bakeries"},
                                                                                      @{@"id": @"beer_and_wine", @"label": @"Beer, Wine & Spirits", @"api_value": @"beer_and_wine"},
                                                                                      @{@"id": @"butcher", @"enabled": @(NO), @"label": @"Butcher", @"api_value": @"butcher"},
                                                                                      @{@"id": @"coffee", @"enabled": @(NO), @"label": @"Coffee & Tea", @"api_value": @"coffee"},
                                                                                      @{@"id": @"foodtrucks", @"enabled": @(NO), @"label": @"Food Trucks", @"api_value": @"foodtrucks"},
                                                                                      ]];
        
        // XXX come up with some better way for initing these
        NSArray *sortByFilters = [Filter buildFilterValuesWithArrayOfDictionaries:@[
                                                                                              @{@"id": @"best_match", @"enabled": @(NO), @"label": @"Best Match", @"api_value": @"0"},
                                                                                              @{@"id": @"distance", @"enabled": @(NO), @"label": @"Distance", @"api_value": @"1"},
                                                                                              @{@"id": @"rating", @"enabled": @(NO), @"label": @"Rating", @"api_value": @"2"},
                                                                                              ]
                                       ];
        _filterGroups = @[
                          [[FilterGroup alloc] initWithIdentifier:@"sort" label:@"Sort By" filters:sortByFilters isCollapsable:YES isCollapsed:YES isExpandable:YES selectedRow:0 rowsWhenCollapsed:1 hasMany:NO],
                          [[FilterGroup alloc] initWithIdentifier:@"category_filter" label:@"Categories" filters:categoryFilters isCollapsable:NO isCollapsed:YES isExpandable:YES selectedRow:0 rowsWhenCollapsed:2 hasMany:YES]
                          ];

    }
    return self;
}

- (RACSignal *)updateRestaurantList {
    return [[self fetchRestaurantsWithTerm:_currentSearchTerm] doNext:^(NSArray *restaurants) {
        [self setCurrentRestaurants:restaurants];
    }];
}

- (RACSignal *)fetchRestaurantsWithTerm:(NSString *)term {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:@{@"term": term, @"location": @"San Francisco"}];
    for (FilterGroup *filterGroup in _filterGroups) {
        Filter *filter = [filterGroup getCurrentSelection];
        parameters[filterGroup.identifier] = filter.apiValue;
    }
    NSLog(@"Search Parameters: %@", parameters);
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

- (FilterGroup *)getFilterGroupForSection:(int)section {
    return _filterGroups[section];
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
