//
//  Restaurant.h
//  Yelp
//
//  Created by mhahn on 6/15/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import <Mantle.h>

@interface Restaurant : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *categories;
@property (nonatomic, strong) NSString *displayPhone;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic) BOOL isClosed;
@property (nonatomic, strong) NSString *displayAddress;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) int rating;
@property (nonatomic, strong) NSURL *ratingImageURL;
@property (nonatomic) int reviewCount;

@end
