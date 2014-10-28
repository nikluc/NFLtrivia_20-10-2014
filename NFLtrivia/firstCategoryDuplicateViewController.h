//
//  firstCategoryDuplicateViewController.h
//  NFLtrivia
//
//  Created by administrator on 10/10/14.
//
//

#import <UIKit/UIKit.h>

@interface firstCategoryDuplicateViewController : UIViewController
- (IBAction)favouriteTeam:(id)sender;
- (IBAction)secondQuestion:(id)sender;
- (IBAction)thirdQuestion:(id)sender;
- (IBAction)resultPage:(id)sender;


@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *profileUrl;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;


@property (nonatomic, strong) NSString *photoId;
@property (nonatomic, strong) NSString *photoName;
@property (nonatomic, strong) NSString *photoViewPro;

@property (weak, nonatomic) IBOutlet UILabel *chooseFavourites;
@property (weak, nonatomic) IBOutlet UILabel *secondQuestions;
@property (weak, nonatomic) IBOutlet UILabel *thirdQuestions;

@property (weak, nonatomic) IBOutlet UIButton *favouriteTeam;
@property (weak, nonatomic) IBOutlet UIButton *secondQuestion;
@property (weak, nonatomic) IBOutlet UIButton *thirdQuestion;
@property (weak, nonatomic) IBOutlet UIButton *resultPage;


@end
