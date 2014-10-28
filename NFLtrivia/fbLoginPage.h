//
//  fbLoginPage.h
//  NFLtrivia
//
//  Created by administrator on 12/09/14.
//
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>


@interface fbLoginPage : UIViewController<FBLoginViewDelegate>

{
    NSTimer *timer;
}

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@end
