//
//  TableDetailController.m
//  SocialFitness
//
//  Created by Hendrik on 10.06.13.
//  Copyright (c) 2013 de.beuth-hochschule. All rights reserved.
//

#import "TableDetailController.h"

@interface TableDetailController ()

@end

@implementation TableDetailController

@synthesize mapView;
@synthesize mapLoadIndicator;
@synthesize routeLine;
@synthesize routeLineView;
@synthesize FileName = _FileName;
@synthesize positionsFromFile;

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
    self.mapLoadIndicator.hidesWhenStopped = YES;
    
    [mapView setMapType:MKMapTypeStandard];
	[mapView setZoomEnabled:YES];
	[mapView setScrollEnabled:YES];
    
    positionsFromFile = [self loadRouteData:_FileName];
    
    /*
    MKPointAnnotation *startAnnotation = [MKPointAnnotation new];
    startAnnotation.coordinate=CLLocationCoordinate2DMake([positionsFromFile[0] doubleValue]
                                                          , [positionsFromFile[1] doubleValue]);
    startAnnotation.title=[NSString stringWithFormat:@"Start"];
    [self.mapView addAnnotation:startAnnotation];
    
    NSInteger len = [positionsFromFile count];
    MKPointAnnotation *stopAnnotation = [MKPointAnnotation new];
    stopAnnotation.coordinate=CLLocationCoordinate2DMake([positionsFromFile[len-1] doubleValue],
                                                         [positionsFromFile[len-1] doubleValue]);
    stopAnnotation.title=[NSString stringWithFormat:@"Stop"];
    [self.mapView addAnnotation:stopAnnotation];
    */
    //self.routeLine = [MKPolyline polylineWithCoordinates: count:[positionsFromFile count]];
    //[self.mapView setVisibleMapRect:[self.routeLine boundingMapRect]];
    //[self.mapView addOverlay:self.routeLine];
    //self.mapView.region = MKCoordinateRegionMake(coordinateArray[0], MKCoordinateSpanMake(0.002,0.002));

    //_mapView.centerCoordinate = coordinateArray[0];
    //_mapView.showsUserLocation = YES;
    //Linie zeichnen
    [mapView setDelegate:self];	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToTable:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}
- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView
{
    [self.mapLoadIndicator startAnimating];
}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    [self.mapLoadIndicator stopAnimating];
    //self.mapView.centerCoordinate=CLLocationCoordinate2DMake(2.506714, 13.332834);
}
-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if(overlay == self.routeLine)
    {
        if(nil == self.routeLineView)
        {
            self.routeLineView = [[MKPolylineView alloc] initWithPolyline:self.routeLine];
            self.routeLineView.fillColor = [UIColor redColor];
            self.routeLineView.strokeColor = [UIColor redColor];
            self.routeLineView.lineWidth = 5;
            
        }
        
        return self.routeLineView;
    }
    
    return nil;
}

#pragma loadRouteDataFromFile
//Positionsdaten aus file laden
-(NSArray *)loadRouteData:(NSString *)fileName
{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath    = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    NSMutableDictionary *rootObject;
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSArray *locations = [[NSArray alloc] init];
    if ([rootObject valueForKey:@"CLLocations"]) {
        locations = [rootObject valueForKey:@"CLLocations"];
    }
    NSLog(@"LocationsfromFile: %@",locations);
    return locations;
}
@end
