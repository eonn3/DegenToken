/* 
Requirements
1. Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
2. Transferring tokens: Players should be able to transfer their tokens to others.
3. Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
4. Checking token balance: Players should be able to check their token balance at any time.
5. Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
*/
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    constructor(address initialOwner) ERC20("Degen", "DGN") Ownable(initialOwner) {
        // set item prices
        itemPrices[COLA] = COLA_PRICE;
        itemPrices[CALPIS] = CALPIS_PRICE;
        itemPrices[CAPRI_SUN] = CAPRI_SUN_PRICE;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }

    function getBalance() external view returns (uint256) {
        return this.balanceOf(msg.sender);
    }

    function transferTokens(address to, uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Insufficient Degen balance");
        approve(msg.sender, amount);
        transferFrom(msg.sender, to, amount);
    }

    function burnTokens(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Insufficient Degen balance");
        _burn(msg.sender, amount);
    }

    // item constants
    bytes32 public constant COLA = keccak256("COLA");
    bytes32 public constant CALPIS = keccak256("CALPIS");
    bytes32 public constant CAPRI_SUN = keccak256("CAPRI_SUN");

    // item prices
    uint256 public constant COLA_PRICE = 45;
    uint256 public constant CALPIS_PRICE = 50;
    uint256 public constant CAPRI_SUN_PRICE = 20;

    // mapping of items to prices
    mapping(bytes32 => uint256) public itemPrices;

    event TokensRedeemed(address indexed redeemer, bytes32 item, uint256 price);

    function redeemTokens(uint8 choice) public {
        if (choice == 1) {
            redeem(COLA);
        } else if (choice == 2) {
            redeem(CALPIS);
        } else if (choice == 3) {
            redeem(CAPRI_SUN);
        } else {
            revert("Invalid choice");
        }
    }

    function redeem(bytes32 item) public {
        require(balanceOf(msg.sender) >= itemPrices[item], "Insufficient Degen balance");
        burn(itemPrices[item]);
        emit TokensRedeemed(msg.sender, item, itemPrices[item]);
    }

    function showStoreItems() public pure returns (string memory) {
        return "Store items: (1) Cola - 45 DGN, (2) Calpis - 50 DGN, (3) Capri Sun - 20 DGN";
    }
}
