//
//  YelpClient.m
//  Yelp
//
//  Created by mhahn on 6/15/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import <Mantle.h>
#import <ReactiveCocoa.h>

#import "Constants.h"
#import "Restaurant.h"
#import "YelpClient.h"

@interface YelpClient()

@end

@implementation YelpClient

- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret {
    
    NSURL *baseURL = [NSURL URLWithString:(NSString *)kYelpAPIBaseURL];
    self = [super initWithBaseURL:baseURL
                      consumerKey:consumerKey
                   consumerSecret:consumerSecret];
    if (self) {
        BDBOAuthToken *token = [BDBOAuthToken tokenWithToken:accessToken
                                                      secret:accessSecret
                                                  expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

- (RACSignal *)fetchJSONFromURL:(NSDictionary *)parameters {
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        AFHTTPRequestOperation *operation = [self GET:@"search" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        
        [operation start];
        
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }] doError:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
