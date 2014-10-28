//
//  firstCategoryViewController.h
//  NFLtrivia
//
//  Created by administrator on 17/09/14.
//
//

#import <UIKit/UIKit.h>



@interface firstCategoryViewController : UIViewController

{
    IBOutlet UILabel * result;
    NSTimer * timer;
    int currentTime;

  NSArray *artArrayQuestionDetails;  
  IBOutlet UILabel * questionOne;
    IBOutlet UILabel * optA;
    IBOutlet UILabel * optB;
    IBOutlet UILabel * optC;
    IBOutlet UILabel * optD;
   
    
}

- (void)populateLabelwithTime:(int)milliseconds;

-(IBAction)optionA;
-(IBAction)optionB;
-(IBAction)optionC;
-(IBAction)optionD;

@property (nonatomic, strong) NSString *photoId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *photoName;
@property (nonatomic, strong) NSString *photoViewPro;
//@property (nonatomic, strong) NSString *directTeamId;








@end
