//
//  Filter.h
//  Yelp
//
//  Created by mhahn on 6/17/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filter : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSArray *filterValues;
@property (nonatomic) BOOL isCollapsable;
@property (nonatomic) BOOL isCollapsed;
@property (nonatomic) int selectedRow;

- (id)initWithIdentifier:(NSString *)identifier label:(NSString *)label filterValues:(NSArray *)filterValues isCollapsable:(BOOL)isCollapsable isCollapsed:(BOOL)isCollapsed selectedRow:(int)selectedRow;

- (void)toggleCollapsed:(int)selectedRow;

@end
