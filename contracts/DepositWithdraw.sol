// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Withdraw {
    
    function deposit() external payable {
        // 해당 function으로 컨트렉에 이더 전송할 수 있음
    }
    
    function withdraw() external {
        // address payable to = payable(msg.sender); // 아무나 빼갈 수 있음
        address payable to = payable(0xD95E156aF86c20efa9BE5968AEDAB343393d11F4); // 지정 주소로 이더가 전송됨
        to.transfer(address(this).balance);
    }
}