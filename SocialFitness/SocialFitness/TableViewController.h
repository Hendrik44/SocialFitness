//
//  TableViewController.h
//  SocialFitness
//
//  Created by Hendrik on 06.06.13.
//  Copyright (c) 2013 Hendrik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIControl.h>
#import <UIKit/UIKitDefines.h>

@interface TableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

//Funktion zum benennen und erstellen der Zellen im Table View, Zellen erhalten einen Index
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

//edit Button abfragen, ob gedrückt wurde, dann Funktion einleiten zum löschen des Zelle im Table View
- (IBAction)editButtonClicked:(id)sender;

//Table View refresh durch "runterziehen" (Nur Signal und Bezeichnung)
- (void)refreshControlRequest;

//Tabel View refresh Aufruf durch -(void)refreshControlRequest
- (void)updateTableView;

@property (strong, nonatomic) IBOutlet UITableView *DataTableVIew;
@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,strong) NSString *filename;

@end
