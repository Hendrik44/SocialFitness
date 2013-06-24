//
//  TableViewController.m
//  SocialFitness
//
//  Created by Hendrik on 06.06.13.
//  Copyright (c) 2013 Hendrik. All rights reserved.
//http://www.techrepublic.com/blog/ios-app-builder/ios-6-best-practices-introducing-the-uirefreshcontrol/314

#import "TableViewController.h"
#import "TableDetailController.h"
#import "recordDataController.h"

@interface TableViewController ()

@end

@implementation TableViewController
{
    int i;
}

@synthesize data = _data;
@synthesize filename;





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
    i = 0;
    [super viewDidLoad];
    [self setupRefreshControl];

    self.data = [[NSMutableArray alloc] initWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/",NSHomeDirectory()] error:nil]];
    
    NSLog(@"%@",[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/",NSHomeDirectory()] error:nil]);
        /*
    [self.data addObject:@"Route1"];
    [self.data addObject:@"Route2"];
    [self.data addObject:@"Route3"];
    [self.data addObject:@"Route4"];*/
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setupRefreshControl
{
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    
    [refreshControl addTarget:self action:@selector(refreshControlRequest)forControlEvents:UIControlEventValueChanged];
    
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Updating data"];
    
    
    [self setRefreshControl:refreshControl];
}


- (void)refreshControlRequest {
    // do something here to refresh.
    NSLog(@"refreshControlRequest!!!");
    
   [self performSelector:@selector(updateTableView)withObject:nil];
    
}

- (void)updateTableView
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM d, h:mm:ss a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@",[formatter stringFromDate:[NSDate date]]];
    
    self.data = [[NSMutableArray alloc] initWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/",NSHomeDirectory()] error:nil]];
    NSLog(@"%@",[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/",NSHomeDirectory()] error:nil]);

    
    
    NSLog(@"update geht");
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    
    
    
    
    [self.refreshControl endRefreshing];
    
    
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
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    return cell;
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Geklickt auf %@",[self.data objectAtIndex:indexPath.row]);
    filename=[self.data objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ShowTableDetails" sender:tableView];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ShowTableDetails"]) {
        TableDetailController *svc = segue.destinationViewController;
        svc.fileName = filename;
        //NSLog(@"Segue: svc: %@ filename:%@",svc.FileName,filename);
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    filename=[self.data objectAtIndex:indexPath.row];
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),filename]
                                                   error:Nil];
        
            [self.data removeObjectAtIndex: indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSLog(@"loeschen erfolgreich");
        }
        else {
            NSLog(@"loeschen fehlgeschlagen");
        
        }

    
    [self.tableView reloadData];
}

- (IBAction)editButtonClicked:(id)sender
{


    if (i == 0) {
        [self.tableView setEditing:YES animated:YES];
        i = 1;
    } else {
    
        [self.tableView setEditing:NO animated:YES];
        i = 0;
    }

        
    
    
}

@end
