//
//  GeneratedUsersTableView.m
//  Random User Generator
//
//  Created by Greg Barbosa on 1/30/14.
//  Copyright (c) 2014 PolaritySoftware. All rights reserved.
//

#import "GeneratedUsersTableView.h"
#import "RandomlyGeneratedUser.h"
#import "UserTableViewCell.h"

#define RANDOM_USER_ME_URL @"http://api.randomuser.me/0.3.2/"

#define UIColorFromRGB(rgbValue) [UIColor \
                                    colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                    green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                    blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface GeneratedUsersTableView ()

@end

@implementation GeneratedUsersTableView

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self generateRandomUsers];
    
    //Initialize the refresh control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:refreshControl];
}

- (void) generateRandomUsers{
    int numberOfUsersToRandomlyGenerate = arc4random_uniform(10)+1;
//    NSLog(@"%d", numberOfUsersToRandomlyGenerate);
    
    //Creates the JSON data object using contents of the URL that was generated in the step prior
    NSData *jsonData = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString:
                         [NSString stringWithFormat:@"%@?results=%d", RANDOM_USER_ME_URL, numberOfUsersToRandomlyGenerate]]];
    NSError *error = nil;
    
    //Creates the NSDictionary that will serialize and hold	 the data from the JSON data object
    NSDictionary *randomlyGeneratedUserDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    //Sets the NSDictionary equal to the JSON data file's 'results' array. This allows the dictionary to solely contain the 'results' array and nothing else.
    self.randomlyGeneratedUsersArray = [NSMutableArray array];
    self.randomlyGeneratedUsersArray = [randomlyGeneratedUserDictionary objectForKey:@"results"];
//    NSLog(@"%@", self.randomlyGeneratedUsersArray);
}

- (void)refresh:(id)sender
{
    [self generateRandomUsers];
    [self.tableView reloadData];
    [(UIRefreshControl *)sender endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.randomlyGeneratedUsersArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    RandomlyGeneratedUser *randomlyGeneratedUser = [[RandomlyGeneratedUser alloc] init];
    
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *generatedUsers = [self.randomlyGeneratedUsersArray objectAtIndex:indexPath.row];
    
    //Grabs the picture URL to eventually set it as the cell's imageView
    NSURL *url = [NSURL URLWithString:[generatedUsers valueForKeyPath:@"user.picture"]];
    
    randomlyGeneratedUser.userFullName = [NSString stringWithFormat:@"%@ %@",
                                           [generatedUsers valueForKeyPath:@"user.name.first"],
                                           [generatedUsers valueForKeyPath:@"user.name.last"]];
    randomlyGeneratedUser.userStreetAddress = [generatedUsers valueForKeyPath:@"user.location.street"];
    randomlyGeneratedUser.userCityStateZip = [NSString stringWithFormat:@"%@, %@ %@", [generatedUsers valueForKeyPath:@"user.location.city"], [generatedUsers valueForKeyPath:@"user.location.state"], [generatedUsers valueForKeyPath:@"user.location.zip"]];

    //Sets cell contents to a truncation of user's first and last name, the user's location, and the user's picture
    cell.userName.text = [randomlyGeneratedUser.userFullName capitalizedString];
    cell.userAddress.text = [randomlyGeneratedUser.userStreetAddress capitalizedString];
    cell.userCityStateZip.text = [randomlyGeneratedUser.userCityStateZip capitalizedString];
    [cell.userProfileImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]];

    //Creates circular user profile image
    CALayer *imageLayer = cell.userProfileImage.layer;
    [imageLayer setCornerRadius:cell.userProfileImage.layer.bounds.size.height/2];
    [imageLayer setBorderWidth:0];
    [imageLayer setMasksToBounds:YES];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
