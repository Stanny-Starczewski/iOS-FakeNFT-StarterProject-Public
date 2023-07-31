# Эпик "Корзина" #
> Верстка кодом <br>
> Архитектура: MVP

> [Первоначальная декомпозиция задачи](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/issues/1) <br>
> [Мое ревью](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/pull/25) <br>
> [Мое второе ревью](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/pull/23) <br>
> [Описание задачи в .md](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/blob/14a99fb7605719f5db0cacbde552751233a2a59d/FakeNFT/Screens/Cart/README.md)

## Статус задачи ##
Задача реализована.

## Скринкаст ##
https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/assets/11814492/4dbf2df9-e366-49a9-b3dc-75ebfd74bbb5

## Декомпозиция эпика ##

### [Экран с товарами](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/issues/4) ###
> Ожидаемое время разработки: 4 ч. <br>
> Фактическое время разработки: 5 ч. 15 мин.

Задачи:
- [x] верстка `UITableView`
- [x] верстка кастомной ячейки
- [x] верстка нижней панели с кнопкой и суммой
- [x] [реализовать связь с реальными данными](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/issues/27)

### [Экран для пустой корзины](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/issues/8) ###
> Ожидаемое время разработки: 30 мин. <br>
> Фактическое время разработки: 30 мин.

Задачи:
- [x] верстка экрана

### [Экран удаления товаров из корзины](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/issues/5) ###
> Ожидаемое время разработки: 2 ч. <br>
> Фактическое время разработки: 2 ч.

Задачи:
- [x] верстка экрана
- [x] [реализовать связь с реальными данными](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/issues/27)

### [Экран выбора способа оплаты](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/issues/6) ###
> Ожидаемое время разработки: 5 ч. <br>
> Фактическое время разработки: 4 ч.

Задачи:
- [x] верстка `UICollectionView`
- [x] верстка кастомной ячейки
- [x] [верстка веб-вью](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/issues/28)

### [Экраны с результатами оплаты](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/issues/7) ###
> Ожидаемое время разработки: 1 ч. <br>
> Фактическое время разработки: 45 мин.

Задачи:
- [x] верстка экранов
- [x] [реализовать связь с реальными данными](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/issues/27)

### [Связь экранов с сетевыми данными](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/issues/27)  ###
Задачи:
- [x] загрузка данных для отображения товаров в корзине (`GET /api/v1/orders/1`)
- [x] реализация удаления товаров из корзины (`PUT /api/v1/orders/1`)
- [x] реализация симуляции оплаты товаров (`GET /api/v1/orders/1/payment/{currency_id}`)

> Ожидаемое время разработки: 7 ч. <br>
> Фактическое время разработки: 13 ч.

# Итого #
> Ожидаемое время разработки: 19 ч. 30 мин. <br>
> Фактическое время разработки: 25 ч. 30 мин.
