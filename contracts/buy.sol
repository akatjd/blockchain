// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract Mouse {
    // view 없으면 write contract
    function simple() public payable {
        
    }

    // contract에 있는 이더 인출
    function withdraw() public {
        address payable to = payable(msg.sender);
        to.transfer(address(this).balance);
    }
}