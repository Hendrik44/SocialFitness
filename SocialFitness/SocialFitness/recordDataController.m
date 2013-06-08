//
//  recordDataController.m
//  SocialFitness
//
//  Created by Hendrik on 07.06.13.
//  Copyright (c) 2013 Hendrik. All rights reserved.
//

#import "recordDataController.h"

@interface recordDataController ()

@end

@implementation recordDataController
@synthesize locMgr;
@synthesize startdate;
@synthesize mapView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    startdate = [NSDate date];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
