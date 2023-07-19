// Your task is to create a ERC20 token and deploy it on the Avalanche network for Degen Gaming. The smart contract should have the following functionality:

// Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
// Transferring tokens: Players should be able to transfer their tokens to others.
// Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
// Checking token balance: Players should be able to check their token balance at any time.
// Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed

//SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract Degan_Network_Token is ERC20 , Ownable , ERC20Burnable{
    mapping(address => bool) public isAllowedToRedeem;
    constructor()ERC20("Degan","DGN"){}

    function mint(address to,uint amount ) public onlyOwner{
        //only owner has the access to mint tokens
        _mint(to,amount);
    }

    function transferringtokens(address _receiver,uint _value) public {
        //players can transfer tokens to others
        require(isAllowedToRedeem[msg.sender], "Redemption not allowed for this address");
        require(balanceOf(msg.sender) >= _value, "Degen tokens are not enough");
        require(balanceOf(msg.sender)>=_value,"Degan tokens are not enough");
        _transfer(msg.sender, _receiver, _value);
    }

    function redeemingtokens( uint _amount) public {
        // Players should be able to redeem their tokens for items in the in-game store
        require(balanceOf(msg.sender) >= _amount, "Degen tokens are not enough");
        //transfering tokens after redeeming them
        _transfer(msg.sender, address(this), _amount);
    }

    function tokenbalance()public view returns(uint){
        //Players should be able to check their token balance at any time
        return this.balanceOf(msg.sender);
    }

    function burningtokens(uint _value) public{
        //Anyone should be able to burn tokens, that they own, that are no longer needed
        require(balanceOf(msg.sender)>=_value,"Degan tokens are not enough");
        _burn(msg.sender, _value);
    }

    function tokenAction(uint action, address _receiver, uint256 _amount) public onlyOwner {
    // Perform various token actions based on the action code provided
    // 1: Mint new tokens
    // 2: Transfer Tokens
    // 3: Allow redemption of tokens
    // 4: Know the token balance
    // 5: Burning Tokens



    require(action >= 1 && action <= 5, "Invalid action code");

    if (action == 1) {
        mint(_receiver, _amount);
    } else if (action == 2) {
        transferringtokens(_receiver,_amount);
    } else if (action == 3) {
        redeemingtokens(_amount);
    } else if (action == 4) {
        tokenbalance();
    }
    else if (action==5){
        burningtokens(_amount);
    }
}

}
