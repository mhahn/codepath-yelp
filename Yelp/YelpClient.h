//
//  YelpClient.h
//  Yelp
//
//  Created by mhahn on 6/15/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import <ReactiveCocoa.h>

@interface YelpClient : BDBOAuth1RequestOperationManager

- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret;

- (RACSignal *)fetchJSONFromURL:(NSDictionary *)parameters;

@end