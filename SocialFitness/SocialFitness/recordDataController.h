//
//  recordDataController.h
//  SocialFitness
//
//  Created by Hendrik on 07.06.13.
//  Copyright (c) 2013 Hendrik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface recordDataController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic, strong) CLLocationManager *locMgr;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) MKCoordinateSpan *span;

@property (nonatomic,strong) NSDate *startdate;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) IBOutlet UILabel *showTimer;


@property (nonatomic,strong) NSString *fileName;
@property (strong, nonatomic) IBOutlet UILabel *showFileName;
@property (nonatomic,strong) NSMutableArray *dataToSave;
-(void)savedata:(NSString*) fileName :(NSMutableDictionary*) saveToFile;

@end
