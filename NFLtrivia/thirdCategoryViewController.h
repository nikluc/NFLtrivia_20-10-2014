//
//  thirdCategoryViewController.h
//  NFLtrivia
//
//  Created by administrator on 13/10/14.
//
//

#import <UIKit/UIKit.h>

@interface thirdCategoryViewController : UIViewController
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


@property (weak, nonatomic) IBOutlet UILabel *thirdCategoryQuestion;

- (IBAction)thirdOptA:(id)sender;
- (IBAction)thirdOptB:(id)sender;
- (IBAction)thirdOptC:(id)sender;
- (IBAction)thirdOptD:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabelA;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabelB;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabelC;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabelD;

@end
