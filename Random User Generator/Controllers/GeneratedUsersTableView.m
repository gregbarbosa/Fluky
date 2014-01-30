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

#define RANDOM_USER_ME_URL @"http://api.randomuser.me/0.3/"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface GeneratedUsersTableView ()

@end

@implementation GeneratedUsersTableView

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Initialize the refresh control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    //Configure refresh control
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    //Configure View Controller
    [self setRefreshControl:refreshControl];
    [self.refreshControl setTintColor:UIColorFromRGB(0xC644FC)];
    
    /**********/
    int numberOfUsersToRandomlyGenerate = arc4random_uniform(5);
    
    //Creates the JSON data object using contents of the URL that was generated in the step prior
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@?results=%d", RANDOM_USER_ME_URL, numberOfUsersToRandomlyGenerate]]];
    
    NSError *error = nil;
    if (error == nil) {
        NSLog(@"Results returned NULL!");
    }
    //Creates the NSDictionary that will serialize and hold	 the data from the JSON data object
    NSDictionary *randomlyGeneratedUserDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    //Sets the NSDictionary equal to the JSON data file's 'results' array. This allows the dictionary to solely contain the 'results' array and nothing else.
    self.randomlyGeneratedUsersArray = [NSMutableArray array];
    self.randomlyGeneratedUsersArray = [randomlyGeneratedUserDictionary objectForKey:@"results"];
}

- (void)refresh:(id)sender
{
    int numberOfUsersToRandomlyGenerate = arc4random_uniform(10);
    
    //Creates the JSON data object using contents of the URL that was generated in the step prior
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@?results=%d", RANDOM_USER_ME_URL, numberOfUsersToRandomlyGenerate]]];
    
    //Generates URL from the provided API URL while generating a random number between 1 and 5 (5 being the limitation of requests from the API URL) and adding the randomly generated number to the suffix of the string. This will send back a random number of randomly generated users
    //    NSURL *randomUserURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?results=%d", RANDOM_USER_ME_URL, numberOfUsersToRandomlyGenerate]];
    
    NSError *error = nil;
    //Creates the NSDictionary that will serialize and hold the data from the JSON data object
    NSDictionary *randomlyGeneratedUserDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    //    NSDictionary *randomlyGeneratedUserDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
    
    //    NSLog(@"%@", randomlyGeneratedUserDictionary);
    
    //Sets the NSDictionary equal to the JSON data file's 'results' array. This allows the dictionary to solely contain the 'results' array and nothing else.
    self.randomlyGeneratedUsersArray = [NSMutableArray array];
    //    NSArray *randomlyGeneratedUsersTempArray = [randomlyGeneratedUserDictionary objectForKey:@"results"];
    self.randomlyGeneratedUsersArray = [randomlyGeneratedUserDictionary objectForKey:@"results"];
    [self.tableView reloadData];
    
    [(UIRefreshControl *)sender endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.randomlyGeneratedUsersArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *generatedUsers = [self.randomlyGeneratedUsersArray objectAtIndex:indexPath.row];

    //Grabs the picture URL to eventually set it as the cell's imageView
    NSURL *url = [NSURL URLWithString:[generatedUsers valueForKeyPath:@"user.picture"]];

    //Sets cell contents to a truncation of user's first and last name, the user's location, and the user's picture
    cell.userName.text = [NSString stringWithFormat:@"%@ %@", [generatedUsers valueForKeyPath:@"user.name.first"], [generatedUsers valueForKeyPath:@"user.name.last"]];
    cell.userAddress.text = [generatedUsers valueForKeyPath:@"user.location.street"];
    cell.userCityStateZip.text = [NSString stringWithFormat:@"%@, %@ %@", [generatedUsers valueForKeyPath:@"user.location.city"], [generatedUsers valueForKeyPath:@"user.location.state"], [generatedUsers valueForKeyPath:@"user.location.zip"]];
    [cell.userProfileImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]];

    //Creates circular user profile image
    CALayer *imageLayer = cell.userProfileImage.layer;
    [imageLayer setCornerRadius:cell.userProfileImage.layer.bounds.size.height/2];
    [imageLayer setBorderWidth:0];
    [imageLayer setMasksToBounds:YES];

    return cell;

    //Some effects to round the images to be more circular. The corner radius value should be half the value that the image size returns. Because I haven't written variables for this yet (not until my custom view is up), I have just set it to half the size of each cell.
    //    [cell.imageView setClipsToBounds:YES];
    //    cell.imageView.layer.cornerRadius = (cell.imageView.bounds.size.height/2);
    //    NSLog(@"Cell imageView bounds height: %f", cell.imageView.bounds.size.height);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
