//
//  secondCategoryViewController.h
//  NFLtrivia
//
//  Created by administrator on 08/10/14.
//
//

#import <UIKit/UIKit.h>

@interface secondCategoryViewController : UIViewController

{
    IBOutlet UILabel * result;
    NSTimer * timer;
    int currentTime;
    NSArray *artArrayQuestionDetails;
  
    
    
}

@property (nonatomic, strong) NSString *photoId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *photoName;
@property (nonatomic, strong) NSString *photoViewPro;
//@property (nonatomic, strong) NSString *directTeamId;

@property (weak, nonatomic) IBOutlet UILabel *secondCategoryQuestion;

- (IBAction)secondOptA:(id)sender;
- (IBAction)secondOptB:(id)sender;
- (IBAction)secondOptC:(id)sender;
- (IBAction)secondOptD:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *secondLabelA;
@property (weak, nonatomic) IBOutlet UILabel *secondLabelB;
@property (weak, nonatomic) IBOutlet UILabel *secondLabelC;
@property (weak, nonatomic) IBOutlet UILabel *secondLabelD;

@end
