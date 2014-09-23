//
//  GeneratedUsersTableView.h
//  Random User Generator
//
//  Created by Greg Barbosa on 1/30/14.
//  Copyright (c) 2014 Tiny Tugboats. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeneratedUsersTableView : UITableViewController

@property (nonatomic, strong) NSMutableArray *randomlyGeneratedUsersArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end