//
//  individualLogoViewController.h
//  NFLtrivia
//
//  Created by administrator on 11/09/14.
//
//

#import <UIKit/UIKit.h>

@interface individualLogoViewController : UIViewController

{
    UIImageView *imageViewPro;
    
}
@property (nonatomic, retain)IBOutlet UIImageView *imageViewPro;
@property (nonatomic, strong) NSString *photoViewPro;
@property (nonatomic, strong) NSString *photoId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *photoName;


- (IBAction)saluudButton:(id)sender;
- (IBAction)changeTeam:(id)sender;


@end
