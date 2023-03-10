// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Market {
    struct Product {
        string name;
        uint256 price;
        uint256 quantity;
        uint256 productId;
    }

    mapping(uint256 => Product) public products;
    uint256 public productCount;

    function addProduct(string memory _name, uint256 _price, uint256 _quantity,uint256 _productId) public {
        productCount++;
        products[productCount] = Product(_name, _price, _quantity,_productId);
    }

    function buyProduct(uint256 _productId, uint256 _quantity) public payable {
        require(_quantity > 0 && _quantity <= products[_productId].quantity, "Invalid quantity");
        require(msg.value == products[_productId].price * _quantity, "Invalid payment");

        products[_productId].quantity = products[_productId].quantity - _quantity;
        payable(msg.sender).transfer(msg.value);
    }

    function getTotalValue() public view returns (uint256) {
        uint256 totalValue = 0;
        for (uint256 i = 1; i <= productCount; i++) {
            totalValue += products[i].price * products[i].quantity;
        }
        return totalValue;
    }
}

