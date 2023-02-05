# RSS-reader

## Приложение-RSS-ридер издания Lenta.ru
 
### 
__Основной испльзуемый стек:__ ___UIKit, CoreData, Navigation Controller, NetworkService, XML parser, UICollectionView, UIScrollView, custom views+collectionViewCells, UserDefaults.___

__Используемые библеотеки:__ ___SnapKit, Alamofire, SDWebImage.___

__Проект написан на__ ___MVP.___

___

#### Описание:
Приложение получает данные (новости) в формате XML с сайта Lenta.ru, парсит данные и отображает их в CollectionView. При нажатии на новость осуществляется переход на экран с ее изображением, заголовком и описанием. Экран деталей новости реализован с помощью ScrollView. При возвращении на предыдущий экран эта новость будет помечена как проcмотренная. Отображение просмотренности реализовано через UserDefaults, поэтому при перезапуске приложения просмотренность сохраняется. Реализована функция pull to refresh через refreshControl и кнопкой обновить. 

<img src="https://github.com/Artem-Tomilo/RSS-reader/blob/main/rss-reader/res/Gifs/1.gif" width="300">

После загрузки новостей они сохраняются в CoreData, поэтому если отсутствует соединение с интернетом или получить данные не удалось, то будут загружены новости с предыдущего запуска приложения. В случае ошибки получения новостей пользователь будет уведомлен об этом путем получения алерта.

<img src="https://github.com/Artem-Tomilo/RSS-reader/blob/main/rss-reader/res/Gifs/2.gif" width="300">
