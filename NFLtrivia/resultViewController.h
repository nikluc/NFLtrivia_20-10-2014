//
//  resultViewController.h
//  NFLtrivia
//
//  Created by administrator on 13/10/14.
//
//

#import <UIKit/UIKit.h>

@interface resultViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>

{
     NSArray *artArrayResultDetails;
       UIImageView *imageView;
}





@property (nonatomic, retain) UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;



@property (nonatomic, strong) NSString *photoId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *photoName;
@property (nonatomic, strong) NSString *photoViewPro;

@property (nonatomic, strong) NSString *directTeamId;


@end
