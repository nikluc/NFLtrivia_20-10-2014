//
//  twoCategoryViewController.h
//  NFLtrivia
//
//  Created by administrator on 10/10/14.
//
//

#import <UIKit/UIKit.h>

@interface twoCategoryViewController : UIViewController


@property (nonatomic, strong) NSString *photoId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *photoName;
@property (nonatomic, strong) NSString *photoViewPro;
//@property (nonatomic, strong) NSString *directTeamId;



@property (weak, nonatomic) IBOutlet UILabel *selectedFanLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentWeekLabel;
- (IBAction)currentWeekButton:(id)sender;
- (IBAction)selectedFanButton:(id)sender;

@end
