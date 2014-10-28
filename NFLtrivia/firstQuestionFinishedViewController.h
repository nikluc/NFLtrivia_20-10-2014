//
//  firstQuestionFinishedViewController.h
//  NFLtrivia
//
//  Created by administrator on 11/10/14.
//
//

#import <UIKit/UIKit.h>

@interface firstQuestionFinishedViewController : UIViewController
- (IBAction)moveToSecondCategory:(id)sender;


@property (nonatomic, strong) NSString *photoId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *photoName;
@property (nonatomic, strong) NSString *photoViewPro;
@property (nonatomic, strong) NSString *directTeamId;

@end
