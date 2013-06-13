//
//  TableViewController.h
//  SocialFitness
//
//  Created by Hendrik on 06.06.13.
//  Copyright (c) 2013 Hendrik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,strong) NSString *filename;
@end
