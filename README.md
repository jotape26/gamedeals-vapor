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
                "height": 1080,
                "width": 720,
                "imageUrl": "//store-images.s-microsoft.com/image/apps.36292.13674739434371576.46d1be43-7d5d-4b71-90b0-97829522e27b.0b2c29b8-fe0f-4a1c-89d7-ce29529162c1"
            }
        ],
        "relatedProductsID": [
            "9NTNVPJF1405"
        ],
        "productTitle": "Mortal Kombat 11 Ultimate",
        "shortDescription": "Inclui MK11, Pacote de Kombate 1, Expansão Aftermath & Pacote de Kombate 2.\r\n\r\nAssuma o controle dos protetores do Plano Terreno em 2 aclamadas Campanhas do Modo História, enquanto eles tentam impedir Kronika de voltar o tempo e reiniciar a história. Apresenta os 37 lutadores, incluindo Rain, Mileena & Rambo.",
        "publisherName": "Warner Bros. Games",
        "compatibleConsoles": [
            "Xbox One",
            "Xbox Series S|X"
        ]
    },
    "priceInfo": {
        "currencyCode": "BRL",
        "discountPrice": 111.59999999999999,
        "originalMSRP": 279
    },
    "storeURL": "https://www.microsoft.com/pt-br/p/Mortal-Kombat-11-Ultimate/9PG26DBX43L1",
    "productId": "9PG26DBX43L1",
    "platform": "xbx"
}
```

---

