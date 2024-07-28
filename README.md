# Degen Token

This project revolves around the Degen (DGN) Token. It allows the user to mint tokens (minting is exclusive to the owner), transfer their tokens to others, check their balance, burn tokens, and redeem their tokens for items in the store.

## Description

```DegenToken.sol``` holds the contract called ```DegenToken```, representing an ERC20 Token. It is a simple implementation of allowing players to redeem their tokens for items, burn their tokens, check their balance, transfer tokens, and also includes minting for the contract owner.

## Features

### Deploying the Contract

One simple way to deploy the contract is through Remix. Just make sure to connect to an injected environment to deploy it to the testnet. To deploy, an address must be provided. This address is set as the owner of the contract and is the only one who is allowed to mint. The prices of the items are also initialized during deployment as the code is found in the constructor.

### Mint

For this project, only the owner can mint tokens. The ```mint(to, amount)``` function takes an address and an amount as the parameter. Upon a successful transaction, the given amount of tokens is minted and added to the address provided.

### Transfer

The ```transferTokens(to, amount)``` function takes an address and an amount as its parameters. If the balance is sufficient, the amount will be taken from the address of the sender's account and transferred to the address passed to the function.

### Redeem

The ```redeemTokens(choice)``` function takes an integer as its parameter. Based on the integer provided, it will call the ``redeem(item)`` function. The valid choices are 1, 2, 3, corresponding to Cola, Calpis, and Capri Sun, respectively. The ``redeem(item)`` function requires that the balance of the sender is sufficient for the price of the item that they want to redeem. If sufficient, an amount equal to the price of their chosen item will be burned from their wallet, and an event will be emitted to say that the sender has used tokens to redeem their chosen item.

### Balance

The ```getBalance()``` function calls the built-in balanceOf() function to return the balance of the sender.

### Burn

The ```burn(amount)``` function takes an amount to burn. It will be burned from the address of the current account, provided that the balance is sufficient.

## Author

Eonn Domingo

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
