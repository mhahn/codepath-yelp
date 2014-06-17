//
//  ListTableViewController.m
//  Yelp
//
//  Created by mhahn on 6/15/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import <ReactiveCocoa.h>

#import "ListTableViewController.h"
#import "RestaurantTableViewCell.h"
#import "Restaurant.h"
#import "FilterTableViewController.h"
#import "YelpManager.h"

@interface ListTableViewController () {
    NSArray *restaurants;
    UISearchBar *searchBar;
}

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // XXX should this be defaulting to something at first?
    
    // configure the search bar
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    searchBar.delegate = self;
    // XXX why is this flashing?
    self.navigationItem.titleView = searchBar;
    // XXX check out the delegate protocol and listen for text did change to update the view when the user types in their selection.
    
    // XXX set this up to 
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(expandFilterView)];
    self.navigationItem.leftBarButtonItem = filterButton;
    
    // listen for when the manager updates current restaurants
    [[[RACObserve([YelpManager sharedManager], currentRestaurants) ignore:nil] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSArray *currentRestaurants) {
        restaurants = currentRestaurants;
        [self.tableView reloadData];
    }];
    
    self.tableView.rowHeight = 100;
    self.tableView.dataSource = self;
    UINib *restaurantCellNib = [UINib nibWithNibName:@"RestaurantTableViewCell" bundle:nil];
    [self.tableView registerNib:restaurantCellNib forCellReuseIdentifier:@"RestaurantCell"];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [[YelpManager sharedManager] setCurrentSearchTerm:searchText];
}

- (void)expandFilterView {
    [self.navigationController pushViewController:[[FilterTableViewController alloc] init] animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return restaurants.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RestaurantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantCell" forIndexPath:indexPath];
    cell.restaurant = restaurants[indexPath.row];
    return cell;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[YelpManager sharedManager] setCurrentSearchTerm:searchBar.text];
    
}
@end
