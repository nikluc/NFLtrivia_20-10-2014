//
//  cheeseViewController.h
//  NFLtrivia
//
//  Created by administrator on 13/10/14.
//
//

#import <UIKit/UIKit.h>

@interface cheeseViewController : UIViewController


@property (nonatomic, strong) NSString *photoId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *photoName;
@property (nonatomic, strong) NSString *photoViewPro;
//@property (nonatomic, strong) NSString *directTeamId;

- (IBAction)pushToThirdCategory:(id)sender;


@end
