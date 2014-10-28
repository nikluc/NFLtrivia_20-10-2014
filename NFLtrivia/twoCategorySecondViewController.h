//
//  twoCategorySecondViewController.h
//  NFLtrivia
//
//  Created by administrator on 11/10/14.
//
//

#import <UIKit/UIKit.h>

@interface twoCategorySecondViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *teamLogoView;
@property (nonatomic, strong) NSString *photoId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *photoName;
@property (nonatomic, strong) NSString *photoViewPro;
@property (nonatomic, strong) NSString *directTeamId;




- (IBAction)selectedTeamQuestion:(id)sender;
- (IBAction)currentWeekQuestion:(id)sender;
@end
