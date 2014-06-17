//
//  Restaurant.m
//  Yelp
//
//  Created by mhahn on 6/15/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"displayPhone": @"display_phone",
             @"imageUrl": @"image_url",
             @"isClosed": @"is_closed",
             @"displayAddress": @"location.display_address",
             @"ratingImageURL": @"rating_img_url",
             @"reviewCount": @"review_count",
             };
}

+ (NSValueTransformer *)imageURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)ratingImageURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)categoriesJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^(NSArray *categories) {
        NSArray *filteredCategories = [[NSArray alloc] init];
        for (NSArray *category in categories) {
            filteredCategories = [filteredCategories arrayByAddingObject:category[0]];
        }
        return [filteredCategories componentsJoinedByString:@", "];
    }];
}

+ (NSValueTransformer *)displayAddressJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^(NSArray *addressParts) {
        return [[addressParts subarrayWithRange:NSMakeRange(0, [addressParts count] - 1)] componentsJoinedByString:@", "];
    }];
}

@end
