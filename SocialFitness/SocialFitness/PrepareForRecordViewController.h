//
//  PrepareForRecordViewController.h
//  SocialFitness
//
//  Created by Hendrik on 08.06.13.
//  Copyright (c) 2013 de.beuth-hochschule. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrepareForRecordViewController : UIViewController
- (IBAction)textFieldDoneEditing:(id)sender;//dient zum schließen der Tastatur bei erfolgter Eingabe
- (IBAction)startRecordPressed:(id)sender;//Startet Routenaufzeichnung und öffnet recordDataView
@property (strong, nonatomic) IBOutlet UITextField *trackName;//Möglichkeit der Bennenung der zu speichernden Route

@end
