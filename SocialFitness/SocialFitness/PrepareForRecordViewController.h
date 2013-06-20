//
//  PrepareForRecordViewController.h
//  SocialFitness
//
//  Created by Hendrik on 08.06.13.
//  Copyright (c) 2013 de.beuth-hochschule. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrepareForRecordViewController : UIViewController
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)startRecordPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *trackName;

-(NSDictionary*) loadData:(NSString*) fileName;

@end
