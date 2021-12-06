pragma solidity ^0.5.0;

import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";


// Have the KaseiCoinCrowdsale contract inherit the following OpenZeppelin:
// * Crowdsale
// * MintedCrowdsale
contract KaseiCoin is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {


    constructor(
        // @TODO: Fill in the constructor parameters!
        uint256 rate, // rate in KaseiCoins
        KaseiCoin token,  // name of the token
        address payable wallet, // sale beneficiary
        uint goal, // goal for crowdsale
        uint open,
        uint close
        //uint cap

    )
        
    Crowdsale(rate, wallet, token)
    TimedCrowdsale(now, now + 24 weeks)
    CappedCrowdsale(goal)
    RefundableCrowdsale(goal)
        // @TODO: Pass the constructor parameters to the crowdsale contracts.
        public
    {
        // constructor can stay empty
    }
}

contract KaseiCoinSaleDeployer {

    address public token_sale_address;
    address public token_address;


    constructor(
        // @TODO: Fill in the constructor parameters!
        string memory name,
        string memory symbol,
        address payable wallet, // sale beneficiary
        uint goal
        
        

    )
        public
    {
        // @TODO: create the KaseiCoin and keep its address handy
        KaseiCoin token = new KaseiCoin(name, symbol, 0);
        token_address = address(token);

        // @TODO: create the KaseiCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 24 weeks.
        KaseiCoinCrowdsale token_sale = new KaseiCoinCrowdsale(1, token, wallet, goal, now, now + 24 weeks);
        token_sale_address = address(token_sale);
        

        // make the KaseiCoin contract a minter, then have the KaseiCoinSaleDeployer renounce its minter role
        token.addMinter(token_sale_address);
        token.renounceMinter();
    }
}
