//
//  logosCollectionViewController.h
//  NFLtrivia
//
//  Created by administrator on 11/09/14.
//
//

#import <UIKit/UIKit.h>

@interface logosCollectionViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate>



@property (strong, nonatomic) NSMutableArray *nflLogos;

@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;

@end
