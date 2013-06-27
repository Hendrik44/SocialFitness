//
//  TableDetailController.h
//  SocialFitness
//
//  Created by Hendrik on 10.06.13.
//  Copyright (c) 2013 de.beuth-hochschule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TableDetailController : UIViewController <MKMapViewDelegate>
- (IBAction)backToTable:(id)sender;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *mapLoadIndicator;
@property (nonatomic, retain) MKPolyline *routeLine; //für Linie zwischen Start und Stop
@property (nonatomic, retain) MKPolylineView *routeLineView; //View zur Anzeige von Polyline
@property (nonatomic,strong) NSString *FileName;
@property (nonatomic,strong) NSArray *positionsFromFile;
@property (strong, nonatomic) IBOutlet UILabel *showFileName;
@end
