# GameDeals API
API written in Swift using Vapor that exposes all active game deals on the Xbox Live Marketplace. 

## Roadmap
- [x] Xbox Live Deals
- [ ] PlayStation Store Deals
- [ ] Steam Deals

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
        "discountedPrice": 7.9,
        "productID": "BV2ZVP7PJZWL",
        "imageURL": "//store-images.s-microsoft.com/image/apps.33719.71220804959101191.bad88979-60b4-40b4-af6d-182d4534c987.ecf3220f-0497-4cf1-9cee-d46d9d86ecc3",
        "system": "Xbox",
        "originalPrice": 79,
        "gameName": "Far Cry®3 Classic Edition"
    }
]
```

---
[https://gamedeals-vapor.herokuapp.com/getDealDetail](https://gamedeals-vapor.herokuapp.com/getDealDetail) 
and 
[https://gamedeals-vapor.herokuapp.com/getRelatedDetail](https://gamedeals-vapor.herokuapp.com/getRelatedDetail) 

Both URIs return the same response, but `getRelatedDetail` can fetch games outside the active deals list.
* Params: 
```json
{
  "productID" : "BV2ZVP7PJZWL"
}

// "productID" is required to use this URI.
```

* Response:
```json
{
    "platform": "xbx",
    "gameInfo": {
        "productType": "Game",
        "relatedProductsID": [
            "C0KJ40T9QD86",
            "BZJ681VGS36F",
            "BZRD6VL00HLB",
            "C47J6H7MQ27Q",
            "C4D86ZHWZ424",
            "C5K8VH7RPC0T",
            "BWJK7NTJLKV9"
        ],
        "publisherName": "Ubisoft",
        "shortDescription": "\"\"Já contei pra você qual é a definição de insanidade?\"\"\r\n\r\nMilhões de jogadores sabem que a definição de insanidade é não ter jogado Far Cry® 3, o jogo de tiro número um de 2012.*\r\n\r\nAgora estamos em 2018 e você pode experimentar novamente Far Cry® 3 Classic Edition. Crie sua própria aventura na ilha do perigo e da descoberta, no mundo aberto para um jogador, enquanto se aventura pelo lado sombrio da humanidade.",
        "productTitle": "Far Cry®3 Classic Edition",
        "gameImages": [
            {
                "imageUrl": "//store-images.s-microsoft.com/image/apps.33719.71220804959101191.bad88979-60b4-40b4-af6d-182d4534c987.ecf3220f-0497-4cf1-9cee-d46d9d86ecc3",
                "width": 720,
                "height": 1080
            },
            {
                "imageUrl": "//store-images.s-microsoft.com/image/apps.46703.71220804959101191.bad88979-60b4-40b4-af6d-182d4534c987.6032d73d-e556-4468-bdea-d751b107fa68",
                "width": 1920,
                "height": 1080
            },
            {
                "imageUrl": "//store-images.s-microsoft.com/image/apps.45089.71220804959101191.bad88979-60b4-40b4-af6d-182d4534c987.53f79c71-e1c1-4d4e-b13a-fab2b00524dd",
                "width": 584,
                "height": 800
            },
            {
                "imageUrl": "//store-images.s-microsoft.com/image/apps.1920.71220804959101191.bad88979-60b4-40b4-af6d-182d4534c987.1bd53913-3aff-42c9-8d2b-fb0467e78e72",
                "width": 1080,
                "height": 1080
            },
            {
                "imageUrl": "//store-images.s-microsoft.com/image/apps.38226.71220804959101191.bad88979-60b4-40b4-af6d-182d4534c987.30b7e864-0f2c-48a7-a6f2-6fc4c58c21e5",
                "width": 1920,
                "height": 1080
            },
            {
                "imageUrl": "//store-images.s-microsoft.com/image/apps.38505.71220804959101191.bad88979-60b4-40b4-af6d-182d4534c987.f4e71fb2-e446-46e4-8291-e474508a0c71",
                "width": 1920,
                "height": 1080
            },
            {
                "imageUrl": "//store-images.s-microsoft.com/image/apps.40264.71220804959101191.bad88979-60b4-40b4-af6d-182d4534c987.16ccc49b-0df5-4af8-b284-8afd9b8bb708",
                "width": 1080,
                "height": 1080
            },
            {
                "imageUrl": "//store-images.s-microsoft.com/image/apps.33203.71220804959101191.bad88979-60b4-40b4-af6d-182d4534c987.4321198b-3fa1-4cd3-9f07-4482b93de46a",
                "width": 1920,
                "height": 1080
            },
            {
                "imageUrl": "//store-images.s-microsoft.com/image/apps.28502.71220804959101191.bad88979-60b4-40b4-af6d-182d4534c987.2bcdb92c-68b7-4d1e-9a2a-de7795379c17",
                "width": 1920,
                "height": 1080
            },
            {
                "imageUrl": "//store-images.s-microsoft.com/image/apps.10476.71220804959101191.bad88979-60b4-40b4-af6d-182d4534c987.7614aa32-4166-4daf-a97e-136c028fde43",
                "width": 1920,
                "height": 1080
            },
            {
                "imageUrl": "//store-images.s-microsoft.com/image/apps.53627.71220804959101191.bad88979-60b4-40b4-af6d-182d4534c987.801037cf-5c04-4f6d-8a6a-19a5184fc496",
                "width": 1920,
                "height": 1080
            },
            {
                "imageUrl": "//store-images.s-microsoft.com/image/apps.8713.71220804959101191.bad88979-60b4-40b4-af6d-182d4534c987.d8685ae3-a72f-4601-bfad-bc661728d1bf",
                "width": 1920,
                "height": 1080
            }
        ]
    },
    "productId": "BV2ZVP7PJZWL",
    "priceInfo": {
        "currencyCode": "BRL",
        "discountPrice": 7.9,
        "originalMSRP": 79
    }
}
```

---

