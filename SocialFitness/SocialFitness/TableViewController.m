//
//  TableViewController.m
//  SocialFitness
//
//  Created by Hendrik on 06.06.13.
//  Copyright (c) 2013 Hendrik. All rights reserved.

#import "TableViewController.h"
#import "TableDetailController.h"
#import "recordDataController.h"

@interface TableViewController ()

@end

@implementation TableViewController
{
    //IndexVariable zur Unterscheidung ob Delete Button aktiv ist
    int i;
}

@synthesize data = _data;
@synthesize filename;
@synthesize DataTableVIew;

//Table View style Initalisierung
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

//Files on Data laden aus Documents
- (void)viewDidLoad
{
    i = 0;
    [super viewDidLoad];
    //refresh der Zellen bei erst Aufruf
    [self setupRefreshControl];

    self.data = [[NSMutableArray alloc] initWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/",NSHomeDirectory()] error:nil]];
    
    NSLog(@"%@",[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/",NSHomeDirectory()] error:nil]);
   }

//Wenn aktualisiert werden soll wird refeshControlRequest aufgerufen
- (void)setupRefreshControl
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self
                       action:@selector(refreshControlRequest)forControlEvents:UIControlEventValueChanged];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Updating data"];
    [self setRefreshControl:refreshControl];
}

//methode ruft updateTableView auf zum Updaten des TableView inhaltes
- (void)refreshControlRequest {
    NSLog(@"refreshControlRequest!!!");
    
   [self performSelector:@selector(updateTableView)withObject:nil];
    
}

//TableView data wird neu geladen und der Zeitpunkt gespeichert
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
    [DataTableVIew reloadData];
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

//durchzählen der Zellen, vorgabe für den Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.data count];
}

//Jeder Filename wird in je enine Zelle eingetragen
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



#pragma mark - Table view delegate
//Filename festlegen und Segue festlegen
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Geklickt auf %@",[self.data objectAtIndex:indexPath.row]);
    filename=[self.data objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ShowTableDetails" sender:tableView];
}

//bei klicken der Zelle neuen View festlegen
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ShowTableDetails"]) {
        TableDetailController *svc = segue.destinationViewController;
        svc.fileName = filename;
        //NSLog(@"Segue: svc: %@ filename:%@",svc.FileName,filename);
    }
}

//methode zum löschen der Zelle und des Files
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    filename=[self.data objectAtIndex:indexPath.row];
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),filename] error:Nil];
        
            [self.data removeObjectAtIndex: indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSLog(@"loeschen erfolgreich");
        }
        else {
            NSLog(@"loeschen fehlgeschlagen");
        }
    [self.tableView reloadData];
}

//Delete Button aktivieren oder deaktivieren zum löschen
- (IBAction)editButtonClicked:(id)sender
{
    if (i == 0)
    {
        [self.tableView setEditing:YES animated:YES];
        i = 1;
    }
    else
    {
        [self.tableView setEditing:NO animated:YES];
        i = 0;
    }
}
@end
