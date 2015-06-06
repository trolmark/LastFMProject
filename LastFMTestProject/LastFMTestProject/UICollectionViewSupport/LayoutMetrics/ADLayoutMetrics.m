
#import "ADLayoutMetrics.h"
#import "ADSupplementaryLayoutMetrics.h"
#import "ADCellLayoutMetrics.h"

@interface ADLayoutMetrics()

@end

@implementation ADLayoutMetrics


- (void) registerWithCollectionView:(UICollectionView *) collectionView
{
    for (ADCellLayoutMetrics *cellMetrics  in self.cellMetrics) {
        [cellMetrics registerWithCollectionView:collectionView];
    }
    
    for (ADSupplementaryLayoutMetrics* headerMetrics in self.headers) {
        [headerMetrics registerWithCollectionView:collectionView supplementaryKind:UICollectionElementKindSectionHeader];
    }
    
    for (ADSupplementaryLayoutMetrics* footerMetrics in self.footers) {
         [footerMetrics registerWithCollectionView:collectionView supplementaryKind:UICollectionElementKindSectionFooter];
    }
}


- (ADSupplementaryLayoutMetrics *)headerForSection:(NSInteger)section {
    if (section < self.headers.count) {
        return self.headers[section];
    }
    return nil;
}

- (ADSupplementaryLayoutMetrics *)footerForSection:(NSInteger)section {
    if (section < self.footers.count) {
        return self.footers[section];
    }
    return nil;
}

@end
