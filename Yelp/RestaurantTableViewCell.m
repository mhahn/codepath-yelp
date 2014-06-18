//
//  RestaurantTableViewCell.m
//  Yelp
//
//  Created by mhahn on 6/15/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import "RestaurantTableViewCell.h"
#import "UIImageView+MHNetworking.h"

@interface RestaurantTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *restaurantImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UILabel *reviewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

- (void)reloadData;

@end

@implementation RestaurantTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Public Methods

- (void)setRestaurant:(Restaurant *)restaurant {
    _restaurant = restaurant;
    [self reloadData];
}

#pragma mark - Private Methods

- (void)reloadData {
    self.restaurantNameLabel.text = _restaurant.name;
    self.reviewsLabel.text = [[NSString alloc] initWithFormat:@"%d reviews", _restaurant.reviewCount];
    self.addressLabel.text = _restaurant.displayAddress;
    self.categoriesLabel.text = _restaurant.categories;
    [self.restaurantImageView setImageWithURL:_restaurant.imageURL withAnimationDuration:0.5];
    [self.ratingImageView setImageWithURL:_restaurant.ratingImageURL withAnimationDuration:0.5];
}

@end
