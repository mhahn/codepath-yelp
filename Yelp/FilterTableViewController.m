//
//  FilterTableViewController.m
//  Yelp
//
//  Created by mhahn on 6/16/14.
//  Copyright (c) 2014 Michael Hahn. All rights reserved.
//

#import "FilterTableViewController.h"
#import "Filter.h"
#import "FilterValue.h"
#import "YelpManager.h"

@interface FilterTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *filterView;

@end

@implementation FilterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Filters";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[YelpManager sharedManager] filters] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int rows;
    Filter *filter = [[YelpManager sharedManager] getFilterForSection:section];
    if (filter.isCollapsable && filter.isCollapsed) {
        rows = 1;
    } else {
        rows = [filter.filterValues count];
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    // XXX clean this up so the filter value can export a view or something
    Filter *filter = [[YelpManager sharedManager] getFilterForSection:indexPath.section];
    int currentRow;
    if (filter.isCollapsed) {
        currentRow = filter.selectedRow;
    } else {
        currentRow = indexPath.row;
    }
    FilterValue *filterValue = filter.filterValues[currentRow];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", filterValue.label];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    Filter *filter = [[YelpManager sharedManager] getFilterForSection:section];
    
    // XXX clean this up so we use a custom title view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    view.backgroundColor = [UIColor blackColor];
    UILabel *viewTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    viewTitle.text = filter.label;
    viewTitle.textColor = [UIColor whiteColor];
    [view addSubview:viewTitle];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Filter *filter = [[YelpManager sharedManager] getFilterForSection:indexPath.section];
    [filter toggleCollapsed:indexPath.row];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
