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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
- (IBAction)editButtonClicked:(id)sender;
- (void)refreshControlRequest;
- (void)updateTableView;

@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,strong) NSString *filename;

@end
