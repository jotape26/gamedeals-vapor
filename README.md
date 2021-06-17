# GameDeals API
API written in Swift using Vapor that exposes all active game deals on the Xbox Live Marketplace. 

## Roadmap
- [x] Xbox Live Deals
- [ ] PlayStation Store Deals
- [ ] Steam Deals
- [ ] Localization with Client Preferences

## Usage

[https://gamedeals-vapor.herokuapp.com/getAllGameDeals](https://gamedeals-vapor.herokuapp.com/getAllGameDeals)
* Params: 
```json
{
  "platform" : "xbx"
}

// This is an optional param.
// Other options also include "ps" but it's a WIP
```

* Response:
```json
[
    {
        "priceInfo": {
            "currencyCode": "BRL",
            "discountPrice": 7.9000000000000004,
            "originalMSRP": 79
        },
        "productID": "BV2ZVP7PJZWL",
        "productTitle": "Far Cry®3 Classic Edition",
        "gameCoverURL": "//store-images.s-microsoft.com/image/apps.33719.71220804959101191.bad88979-60b4-40b4-af6d-182d4534c987.ecf3220f-0497-4cf1-9cee-d46d9d86ecc3",
        "platform": "xbx"
    }
]
```

---
[https://gamedeals-vapor.herokuapp.com/getProductDetail](https://gamedeals-vapor.herokuapp.com/getProductDetail)

* Params: 
```json
{
  "productID" : "9PG26DBX43L1"
}

// "productID" is required to use this URI.
```

* Response:
```json
{
    "gameInfo": {
        "productType": "Game",
        "gameImages": [
            {
                "height": 800,
                "width": 584,
                "imageUrl": "//store-images.s-microsoft.com/image/apps.61045.70804610839547354.8da93c46-fd13-4b16-8ebe-e8e02c53d93e.4d99a8d0-a5e3-4cb8-a7c9-8110442d9fbf"
            }
        ],
        "relatedProductsID": [
            "C01Z9J8S9BJP"
        ],
        "productTitle": "Mortal Kombat 11",
        "shortDescription": "Mortal Kombat está de volta, melhor do que nunca, em uma evolução da icônica franquia.",
        "publisherName": "Warner Bros. Games",
        "compatibleConsoles": [
            "Xbox One",
            "Xbox Series S|X"
        ]
    },
    "priceInfo": {
        "currencyCode": "BRL",
        "discountPrice": 199.99000000000001,
        "originalMSRP": 199.99000000000001
    },
    "storeURL": "https://www.microsoft.com/pt-br/p/Mortal-Kombat-11/BTC0L0BW6LWC",
    "coverImage": {
        "height": 1080,
        "width": 1080,
        "imageUrl": "//store-images.s-microsoft.com/image/apps.58569.70804610839547354.8da93c46-fd13-4b16-8ebe-e8e02c53d93e.e2faaa62-b30d-4f18-ae5d-28926051374c"
    },
    "productId": "BTC0L0BW6LWC",
    "platform": "xbx"
}
```

---

