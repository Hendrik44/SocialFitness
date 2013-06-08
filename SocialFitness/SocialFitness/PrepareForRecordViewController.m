//
//  PrepareForRecordViewController.m
//  SocialFitness
//
//  Created by Hendrik on 08.06.13.
//  Copyright (c) 2013 de.beuth-hochschule. All rights reserved.
//

#import "PrepareForRecordViewController.h"

@interface PrepareForRecordViewController ()

@end

@implementation PrepareForRecordViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}

@end
