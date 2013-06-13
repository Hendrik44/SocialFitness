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
    
    /* Testdaten schreiben
    [self savedata:@"Test" :[[NSArray alloc]initWithObjects:@"9.91437",@"78.11418",
                             @"9.91825",@"78.11357",
                             @"9.91973",@"78.12013",
                             @"52.53856",@"13.3515",
                             @"52.53753",@"13.35972",
                             @"52.538",@"13.35788",
                             @"52.53844",@"13.35633",
                             @"52.53895",@"13.35392",
                             @"52.53813",@"13.34925",
                             @"52.53794",@"13.34667",
                             @"52.53815",@"13.34504",
                             @"52.5369",@"13.35938",
                             nil]
     ];*/
    /*
     dataToSave-Array: (
     "<+52.50671406,+13.33283424> +/- 5.00m (speed -1.00 mps / course -1.00) @ 6/13/13, 3:11:52 PM Central European Summer Time",
     "<+52.50649300,+13.33258200> +/- 5.00m (speed -1.00 mps / course -1.00) @ 6/13/13, 3:11:54 PM Central European Summer Time",
     "<+52.50625900,+13.33229100> +/- 5.00m (speed -1.00 mps / course -1.00) @ 6/13/13, 3:11:55 PM Central European Summer Time"
     )
     */
    //[self savedata:_fileName :[[NSArray alloc] initWithArray:dataToSave]];
    
    NSLog(@"dataToSave-Array: %@",dataToSave);
    [self savedata:_fileName :dataToSave];
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
-(void)savedata:(NSString*) fileName :(NSArray*) saveToFile
{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath    = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    
    NSMutableDictionary *rootObject;
    rootObject = [NSMutableDictionary dictionary];
    
    [rootObject setValue:dataToSave forKey:@"CLLocations"];
    
    [NSKeyedArchiver archiveRootObject:rootObject toFile:filePath];   
}
@end
