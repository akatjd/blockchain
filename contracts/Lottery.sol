// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract Lottery is AccessControl {

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant MANAGER_ROLE = keccak256("MANAGER_ROLE");

    // 생성자에게 admin role 부여
    constructor() {
        _grantRole(ADMIN_ROLE, msg.sender);
    }

    mapping (address => uint256) user;
    // 0xaaabcccdddd => 7
    // 0xadsadsdddww => 1 ...
    uint256 total_users;
    uint256 winning_number;
    uint256 winning_ether;
    // uint256[50] cal_users;
    uint256[] cal_users;
    
    // 생성자만 manager role을 부여할 수 있음
    function grant_manager_role(address manager_address) public onlyRole(ADMIN_ROLE) {
        _grantRole(MANAGER_ROLE, manager_address);
    }

    function set_arr_size(uint256 size) public onlyRole(ADMIN_ROLE) {
        // cal_users = new uint256[](size);
        for (uint i = 1; i <= size; i++) {
            cal_users.push(0);
        }
    }

    // payable을 붙여야 트젝날릴때 돈을 낼 수 있음
    function lottery_in(uint256 number) public payable {
        if(msg.value == 0.01 ether) {
            user[msg.sender] = number;
            total_users++;
            cal_users[number] = cal_users[number] + 1;
        }else {
            // transaction fail 시킴
            revert();
        }
    }

    // 당첨번호는 admin, manager role만 부여할 수 있음
    function lottery_set(uint256 number) public {
        if(hasRole(ADMIN_ROLE, msg.sender) || hasRole(MANAGER_ROLE, msg.sender)) {
            winning_number = number;
            // 당첨자끼리 나누는걸로 바꿔야 함
            winning_ether = address(this).balance / total_users;
            // winning_ether = address(this).balance / cal_users[number];
        }else {
            revert();
        }
    }

    function claim() public {
        if(user[msg.sender] == winning_number) {
            address payable to = payable(msg.sender);
            to.transfer(address(this).balance);
        }else {
            // revert도 가스비 날아감
            revert();
        }
    }
}