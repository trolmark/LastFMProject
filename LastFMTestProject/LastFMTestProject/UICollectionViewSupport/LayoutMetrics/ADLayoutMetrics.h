
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ADSupplementaryLayoutMetrics;
@interface ADLayoutMetrics : NSObject

@property (nonatomic, strong) NSArray *cellMetrics;
@property (nonatomic, strong) NSArray *headers;
@property (nonatomic, strong) NSArray *footers;


- (void) registerWithCollectionView:(UICollectionView *) collectionView;

- (ADSupplementaryLayoutMetrics *)headerForSection:(NSInteger)section;
- (ADSupplementaryLayoutMetrics *)footerForSection:(NSInteger)section;

@end
