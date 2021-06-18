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
        "productType": "Durable",
        "relatedMedia": [
            {
                "mediaURL": "//store-images.s-microsoft.com/image/apps.37388.14414709572348410.72095bc2-eee1-4d87-9f9b-bc01c18b3f78.2939186e-0da9-4e85-a643-bd368416d270",
                "type": "Image",
                "height": 800,
                "width": 584
            }
        ],
        "relatedProductsID": [
            "BTC0L0BW6LWC"
        ],
        "productTitle": "Mortal Kombat 11: Aftermath",
        "shortDescription": "\"Aftermath\" apresenta uma nova cinemática do modo história centrada ao redor da confiança e de mentiras. Liu Kang Deus do Fogo, o novo guardião do tempo e protetor do Plano Terreno, deseja proteger o futuro previsto por ele. Crie uma nova história.\r\n\r\nInclui:\r\n\r\n• Nova cinemática do modo história",
        "publisherName": "Warner Bros. Interactive Entertainment",
        "compatibleConsoles": [
            "Xbox One",
            "Xbox Series S|X"
        ]
    },
    "priceInfo": {
        "currencyCode": "BRL",
        "discountPrice": 0,
        "originalMSRP": 0
    },
    "storeURL": "https://www.microsoft.com/pt-br/p/Mortal-Kombat-11-Aftermath/9NTNVPJF1405",
    "coverImage": {
        "mediaURL": "//store-images.s-microsoft.com/image/apps.13696.14414709572348410.72095bc2-eee1-4d87-9f9b-bc01c18b3f78.f6dc502c-60dd-4846-a90f-b46514a17154",
        "type": "Image",
        "height": 1080,
        "width": 1080
    },
    "productId": "9NTNVPJF1405",
    "platform": "xbx"
}
```

---

