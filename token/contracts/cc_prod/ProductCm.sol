// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract ProductCm {
    struct ProductIndex {
        bytes32 ProductKey;
        uint valueRef;
    }
    struct Product{
        bytes20 productId;   // id
        bytes20 productTypeId;   // id
        bytes20 primaryProductCategoryId;   // id
        bytes20 facilityId;   // id
        uint256 introductionDate;   // date-time
        uint256 releaseDate;   // date-time
        uint256 supportDiscontinuationDate;   // date-time
        uint256 salesDiscontinuationDate;   // date-time
        bytes1 salesDiscWhenNotAvail;   // indicator
        string internalName;   // description
        string brandName;   // name
        string comments;   // comment
        string productName;   // name
        string description;   // description
        string longDescription;   // very-long
        string priceDetailText;   // description
        string smallImageUrl;   // url
        string mediumImageUrl;   // url
        string largeImageUrl;   // url
        string detailImageUrl;   // url
        string originalImageUrl;   // url
        string detailScreen;   // long-varchar
        string inventoryMessage;   // description
        bytes20 inventoryItemTypeId;   // id
        bytes1 requireInventory;   // indicator
        bytes20 quantityUomId;   // id
        int256 quantityIncluded;   // fixed-point
        int64 piecesIncluded;   // numeric
        bytes1 requireAmount;   // indicator
        int256 fixedAmount;   // currency-amount
        bytes20 amountUomTypeId;   // id
        bytes20 weightUomId;   // id
        int256 shippingWeight;   // fixed-point
        int256 productWeight;   // fixed-point
        bytes20 heightUomId;   // id
        int256 productHeight;   // fixed-point
        int256 shippingHeight;   // fixed-point
        bytes20 widthUomId;   // id
        int256 productWidth;   // fixed-point
        int256 shippingWidth;   // fixed-point
        bytes20 depthUomId;   // id
        int256 productDepth;   // fixed-point
        int256 shippingDepth;   // fixed-point
        bytes20 diameterUomId;   // id
        int256 productDiameter;   // fixed-point
        int256 productRating;   // fixed-point
        bytes20 ratingTypeEnum;   // id
        bytes1 returnable;   // indicator
        bytes1 taxable;   // indicator
        bytes1 chargeShipping;   // indicator
        bytes1 autoCreateKeywords;   // indicator
        bytes1 includeInPromotions;   // indicator
        bytes1 isVirtual;   // indicator
        bytes1 isVariant;   // indicator
        bytes20 virtualVariantMethodEnum;   // id
        bytes20 originGeoId;   // id
        bytes20 requirementMethodEnumId;   // id
        int64 billOfMaterialLevel;   // numeric
        int256 reservMaxPersons;   // fixed-point
        int256 reserv2ndPPPerc;   // fixed-point
        int256 reservNthPPPerc;   // fixed-point
        bytes20 configId;   // id
        uint256 createdDate;   // date-time
        bytes createdByUserLogin;   // id-vlong
        uint256 lastModifiedDate;   // date-time
        bytes lastModifiedByUserLogin;   // id-vlong
        bytes1 inShippingBox;   // indicator
        bytes20 defaultShipmentBoxTypeId;   // id
        string lotIdFilledIn;   // long-varchar
        bytes1 orderDecimalQuantity;   // indicator
    }

    uint numProducts;
    mapping(uint => Product) products;
    mapping(address => ProductIndex[]) public owners;
}
