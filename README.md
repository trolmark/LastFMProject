# LastFMProject

This is a application done as interview task. Main functions : fetch list of groups, artist and albums and provide navigation between them.

Concepts inside
---------------
- [ViewModels](https://github.com/trolmark/LastFMProject/tree/master/LastFMTestProject/LastFMTestProject/ViewModels) - used as presentation wrapper around DTOs.
- [NetworkModels](https://github.com/trolmark/LastFMProject/tree/master/LastFMTestProject/LastFMTestProject/NetworkModels) - used for fetching different kinds of raw data (artists, albums, groups), parse them into DTO -> ViewModels
- [DataSources](https://github.com/trolmark/LastFMProject/tree/master/LastFMTestProject/LastFMTestProject/DataSources) - local storages, used for clean up controllers from data source methods(UICollectionViewDataSource).
- [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa)
