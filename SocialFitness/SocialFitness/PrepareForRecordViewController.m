//
//  PrepareForRecordViewController.m
//  SocialFitness
//
//  Created by Hendrik on 08.06.13.
//  Copyright (c) 2013 de.beuth-hochschule. All rights reserved.
//
//  datenstruct-Aufbau
//  name-der-Route{
//                  location : Zeitstempel
//                }
//

#import "PrepareForRecordViewController.h"
#import "recordDataController.h"

@interface PrepareForRecordViewController ()

@end

@implementation PrepareForRecordViewController
@synthesize trackName;

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
    //userdata = [[NSUserDefaults alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)textFieldDoneEditing:(id)sender{
    //Tastur ausblenden
    [sender resignFirstResponder];
}

- (IBAction)startRecordPressed:(id)sender {
    //Nachricht an segue mit des der auf zu zeichenden Route
    //[self savedata];

}

-(NSDictionary*) loadData:(NSString*) fileName
{
    NSDictionary* loadDataDic = [[NSDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/%@",
                                                                              NSHomeDirectory(),fileName]];
    return loadDataDic;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"startRecordRouteSegue"]) {
        recordDataController *svc = segue.destinationViewController;
        if ([trackName.text isEqualToString:@""])
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd'_'HH:mm"];
            svc.fileName = [dateFormat stringFromDate:[NSDate date]];
        }
        else
        {
            svc.fileName = trackName.text;
        }
    
    }
}
@end
