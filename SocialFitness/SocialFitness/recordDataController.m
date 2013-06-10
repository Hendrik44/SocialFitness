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
@synthesize timer;
@synthesize showTimer;
@synthesize span;
@synthesize fileName = _fileName;
@synthesize dataToSave;

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
    locMgr = [[CLLocationManager alloc] init];
    dataToSave = [[NSMutableArray alloc] init];
    
    [self.locMgr setDelegate:self];
    [[self locMgr] setDistanceFilter:10.0f];
    [[self locMgr] setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    startdate = [NSDate date];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.zoomEnabled = YES;
    self.mapView.scrollEnabled = NO;
    self.showFileName.text = _fileName;
    [locMgr startUpdatingLocation];
    //[NSUserDefaults init];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) tick: (NSTimer*) theTimer
{
    //[showTimer setText:[NSString stringWithFormat:@"%@",[NSDate dateWithTimeInterval:1 sinceDate:startdate]]]
    
    [showTimer setText:[NSString stringWithFormat:@"%.0fs",-[startdate timeIntervalSinceNow]]];
}
- (IBAction)stop:(id)sender {
    [self.locMgr stopUpdatingLocation];
    [self.timer invalidate];
    self.timer= nil;
    
    for (id obj in dataToSave){
        CLLocation *standort = obj;
        NSLog(@"\nZeitstempel: %@\nLatitue: %g\nLongitute: %g\n\n", standort.timestamp,standort.coordinate.latitude,standort.coordinate.longitude);
        
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLog(@"Fehlerchen");
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    self.mapView.region = MKCoordinateRegionMake(newLocation.coordinate, MKCoordinateSpanMake(0.002,0.002));
    /*
    NSLog(@"Position: LAT[%g] LON[%g]",
          newLocation.coordinate.latitude,
          newLocation.coordinate.longitude);
     */
    [self.dataToSave addObject:newLocation];
    [self.mapView setCenterCoordinate:newLocation.coordinate];
    
}
-(void)savedata:(NSString*) fileName :(NSDictionary*) saveToFile
{
    /*
     userDataDic = [[NSDictionary alloc] initWithObjects:([NSString stringWithFormat:@"trackname"]) forKeys:[NSString stringWithFormat:@"%@",self.trackName.text]];
     [userDataDic writeToFile:[NSString stringWithFormat:@"%@/Documents/userdata",NSHomeDirectory()] atomically:YES];
     */
    [saveToFile writeToFile:[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),fileName] atomically:YES];
}
@end
