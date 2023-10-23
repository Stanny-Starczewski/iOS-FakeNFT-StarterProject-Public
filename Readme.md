# Terms of reference for the FakeNFT mobile application

# Links

[Figma Design](https://www.figma.com/file/k1LcgXHGTHIeiCv4XuPbND/FakeNFT-(YP)?node-id=96-5542&t=YdNbOI8EcqdYmDeg-0)<br>
[Profile epic description](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/blob/cb52579f488b0c189f534b7d26035fcc89c2df00/FakeNFT/Presentation/Profile/PROFILE.md)<br>
[Description of the epic Catalog](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/blob/cb52579f488b0c189f534b7d26035fcc89c2df00/FakeNFT/Presentation/Catalog/CATALOG.md)<br>
[Description of the epic Cart](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/blob/cb52579f488b0c189f534b7d26035fcc89c2df00/FakeNFT/Presentation/Cart/CART.md)<br>
[Description of the epic Statistics](https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/blob/cb52579f488b0c189f534b7d26035fcc89c2df00/FakeNFT/Presentation/Stats/STATS.md)

# Screencasts
https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/assets/11814492/974700f1-3b6a-4a2d-91c3-2094b662ab5e

https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/assets/11814492/2227b1cf-7700-4e60-a599-434d661973ac

https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/assets/11814492/81ab5d48-8d6c-4446-8701-b16a1d8944d2

https://github.com/NutsCraker/iOS-FakeNFT-StarterProject-Public/assets/11814492/4843b7e2-ec82-4a83-9ab4-feb5a8f28585



# Purpose and goals of the application

The app helps users browse and buy NFT (Non-Fungible Token). The purchasing functionality is simulated using a mock server.

Application goals:

- viewing NFT collections;
- viewing and purchasing NFT (simulated);
- view user ratings.

# Brief description of the application

- The app showcases a catalog of NFTs structured as collections
- The user can view information about the collection catalog, the selected collection and the selected NFT.
- The user can add favorite NFTs to favorites.
- The user can remove and add items to the cart, as well as pay for the order (the purchase is simulated).
- User can view user rating and user information.
- The user can view information about his profile, including information about favorites and NFTs owned by him.

Additional (optional) functionality is:
- localization
- dark theme
- statistics based on Yandex Metrics
- login screen
- onboarding screen
- an alert with an offer to evaluate the application
- network error message
- custom launch screen
- search by table/collection in your epic

# Functional requirements

## Catalog

**Catalog Screen**

The catalog screen displays a table (UITableView) showing the available NFT collections. For each NFT collection displays:
- collection cover;
- name of the collection;
- number of NFTs in the collection.

There is also a sorting button on the screen, when clicked the user is prompted to select one of the available sorting methods. The contents of the table are ordered according to the selected method.

While the display data is not loaded, a loading indicator should be displayed.

When you click on one of the table cells, the user is taken to the screen of the selected NFT collection.

**NFT collection screen**

The screen displays information about the selected NFT collection, and contains:

- cover of the NFT collection;
- name of the NFT collection;
- text description of the NFT collection;
- name of the author of the collection (link to his website);
- a collection (UICollectionView) with information about the NFT included in the collection.

When you click on the name of the author of the collection, his website opens in webview.

Each collection cell contains:
- NFT image;
- NFT name;
- NFT rating;
- NFT cost (in ETH);
- button to add to favorites / remove from favorites (heart);
- button to add NFT to cart / remove NFT from cart.

Clicking on the heart adds the NFT to favorites / removes the NFT from favorites.

When you click on the add NFT to cart / remove NFT from cart button, NFT is added or removed from the order (cart). The image of the button changes; if the NFT is added to the order, a button with a cross is displayed; if not, a button without a cross is displayed.

Clicking on the cell opens the NFT screen.

**NFT Screen**

The screen is partially implemented by the mentor during life coding. Screen implementation by students is not required.

## Basket

**Order Screen**

The table screen displays a table (UITableView) with a list of NFTs added to the order.
For each NFT the following are indicated:
- image;
- Name;
- rating;
- price;
- button to remove from cart.

When you click on the delete button from the recycle bin, a deletion confirmation screen is displayed, which contains:
- NFT image;
- text about deletion;
- deletion confirmation button;
- button to refuse deletion.

At the top of the screen there is a sorting button, when clicked, the user is prompted to select one of the available sorting methods. The contents of the table are ordered according to the selected method.

At the bottom of the screen there is a panel with the number of NFTs in the order, the total price and the payment button.
When you click on the payment button, you go to the currency selection screen.

While the display data is not loading or being updated, a loading indicator should be displayed.

**Currency selection screen**

The screen allows you to select the currency to pay for the order.

At the top of the screen there is a header and a button to return to the previous screen.
Below it is a UICollectionCell with available payment methods.
For each currency the following is indicated:
- logo;
- full name;
- abbreviated name.

At the bottom there is a text with a link to the user agreement (leads to https://yandex.ru/legal/practicum_termsofuse/, opens in webview).

Below the text is a payment button; when pressed, a request is sent to the server. If the server responded that the payment was successful, a screen with information about this and a return to cart button is displayed. In case of unsuccessful payment, the corresponding screen is shown with buttons for repeating the request and returning to cart.

## Profile

**Profile Screen**

The screen shows information about the user. He contains:
- user photo;
- Username;
- user description;
- a table (UITableView) with cells My NFTs (leads to the user’s NFT screen), Favorite NFTs (leads to the screen with selected NFTs), User’s Site (opens the user’s site in webview).

In the upper right corner of the screen there is a profile editing button. By clicking on it, the user sees a pop-up screen where they can edit the username, description, website and image link. There is no need to upload the image itself through the application; only the link to the image is updated.

**My NFT Screen**

It is a table (UITableView), each cell of which contains:
- NFT icon;
- NFT name;
- NFT author;
- NFT price in ETH.

At the top of the screen there is a sorting button, when clicked, the user is prompted to select one of the available sorting methods. The contents of the table are ordered according to the selected method.

If there is no NFT, the corresponding inscription is shown.

**NFT Favorites Screen**

Contains a collection (UICollectionView) with NFTs added to favorites (liked). Each cell contains information about the NFT:
- icon;
- heart;
- Name;
- rating;
- price in ETH.

Clicking on the heart removes the NFT from your favorites, and the contents of the collection are updated.

If there are no selected NFTs, the corresponding inscription is shown.

## Statistics

**Rating Screen**

The screen displays a list of users. It is a table (UITableView). For each user the following is indicated:
- place in the ranking;
- avatar;
- Username;
- number of NFTs.

At the top of the screen there is a sorting button, when clicked, the user is prompted to select one of the available sorting methods. The contents of the table are ordered according to the selected method.

When you click on one of the cells, you go to the user information screen.

**User Information Screen**

The screen displays information about the user:

- user photo;
- Username;
- user description.

It also contains a button to go to the user’s website (opens in webview) and the ability to go to the user’s Collections screen.

**User Collection Screen**

Contains a collection (UICollectionView) with the user's NFT. Each cell contains information about the NFT:
- icon;
- Name;
- rating.

# Sort data

On the “Catalogue”, “Cart”, “My NFTs”, “Statistics” screens there is a sorting setting. The user-selected sort order must be saved locally on the device. After restarting the application, the previous value is restored.

**Default sort value:**
- “Catalogue” screen – by the number of NFTs;
- “Cart” screen – by name;
- “My NFT” screen – by rating;
- “Statistics” screen - by rating.
