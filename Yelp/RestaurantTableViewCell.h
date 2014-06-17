//
//  RestaurantTableViewCell.h
//  Yelp
//
//  Created by mhahn on 6/15/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"

@interface RestaurantTableViewCell : UITableViewCell

@property (nonatomic, strong) Restaurant *restaurant;

@end
