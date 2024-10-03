// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;


contract Faucet {
    address payable public owner;

    constructor() payable {
        owner = payable(msg.sender);
    } 


    event FallbackCalled();

    function withdraw(uint _amount) payable public {
        //only users can withdraw 1 eth
        require(_amount <= 1000000000000000000);
        (bool sent, ) = payable(msg.sender).call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

    function withdrawAll() onlyOwner public {
        (bool sent, ) = owner.call{value: address(this).balance}("");
    }

    // function destroyFaucet() onlyOwner public {
    //     selfdestruct(owner);
    // }

    

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }


}