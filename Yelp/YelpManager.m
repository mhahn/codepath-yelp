//
//  YelpManager.m
//  Yelp
//
//  Created by mhahn on 6/16/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import <ReactiveCocoa.h>

#import "Constants.h"
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
