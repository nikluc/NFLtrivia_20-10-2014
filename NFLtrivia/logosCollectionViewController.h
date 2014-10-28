//
//  logosCollectionViewController.h
//  NFLtrivia
//
//  Created by administrator on 11/09/14.
//
//

#import <UIKit/UIKit.h>

@interface logosCollectionViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
     NSArray *artArrayTeamList;
    UIImageView *imageView;

}


@property (strong, nonatomic) NSMutableArray *nflLogos;


@property (nonatomic, strong) NSString *photoId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *photoName;
@property (nonatomic, strong) NSString *photoViewPro;




@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;

@end
