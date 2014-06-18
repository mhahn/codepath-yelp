//
//  FilterTableViewController.m
//  Yelp
//
//  Created by mhahn on 6/16/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import "FilterTableViewController.h"
#import "FilterGroup.h"
#import "Filter.h"
#import "FilterTableViewCell.h"
#import "ListTableViewController.h"
#import "SeeAllTableViewCell.h"
#import "YelpManager.h"

@interface FilterTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *filterView;
- (void)filterSearch;
- (void)cancelSearch;

@end

@implementation FilterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Filters";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(filterSearch)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelSearch)];
    
    UINib *filterCellNib = [UINib nibWithNibName:@"FilterTableViewCell" bundle:nil];
    [self.tableView registerNib:filterCellNib forCellReuseIdentifier:@"FilterCell"];
    UINib *seeAllNib = [UINib nibWithNibName:@"SeeAllTableViewCell" bundle:nil];
    [self.tableView registerNib:seeAllNib forCellReuseIdentifier:@"SeeAllCell"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[YelpManager sharedManager] filterGroups] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int rows;
    FilterGroup *filterGroup = [[YelpManager sharedManager] getFilterGroupForSection:section];
    if (filterGroup.isExpandable && filterGroup.isCollapsed) {
        rows = [filterGroup displayRowsWhenCollapsed];
    } else {
        rows = [filterGroup.filters count];
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // XXX clean this up so the filter value can export a view or something
    FilterGroup *filterGroup = [[YelpManager sharedManager] getFilterGroupForSection:indexPath.section];
    int currentRow;
    if (filterGroup.isCollapsed && !(filterGroup.hasMany)) {
        currentRow = filterGroup.selectedRow;
    } else {
        currentRow = indexPath.row;
    }
    
    if (filterGroup.isCollapsed && filterGroup.hasMany && (currentRow > (filterGroup.rowsWhenCollapsed - 1))) {
        SeeAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeeAllCell"];
        return cell;
    } else {
        FilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell" forIndexPath:indexPath];
        Filter *filter = filterGroup.filters[currentRow];
        cell.filter = filter;
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    FilterGroup *filter = [[YelpManager sharedManager] getFilterGroupForSection:section];
    return filter.label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FilterGroup *filterGroup = [[YelpManager sharedManager] getFilterGroupForSection:indexPath.section];

    [filterGroup toggleCollapsed:indexPath.row];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)filterSearch {
    ListTableViewController *vc = [[ListTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cancelSearch {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
