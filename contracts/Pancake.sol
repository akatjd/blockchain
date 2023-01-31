// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract Pancake {
    uint256 round;
    uint256 price = 0.01 ether;
    uint256 winning_price = 0.01 ether;

    // 0회차 ->  [0x1234 -> [1,2,3]]
    // 22회차 -> [0x1234 -> [1,2,5]]
    mapping(uint256 => mapping (address => uint256[])) my_numbers;

    // 0회차 -> [1,2,3]
    // 1회차 -> [1,4,5]
    // 2회차 -> [2,3,5]
    mapping (uint256 => uint256[]) winning_numbers; 
    
    function lottery_in(uint256[] memory numbers) public payable {
        if(msg.value == price) {
            my_numbers[round][msg.sender] = numbers;
        }else {
            revert("Not enough ETH");
        }
    }
    
    function lottery_set(uint256[] memory numbers) public {
        winning_numbers[round] = numbers;
        round++;
    }

    function claim(uint256 this_round) public {
        uint256 point = 0;
        // 같은 자리에 같은 번호인지 확인
        if(winning_numbers[this_round][0] == my_numbers[this_round][msg.sender][0]) {
            // ex)
            // 라운드 0 -> [0x1234 -> [1,2,3]]
            // 당첨번호 라운드 0 -> [1,3,4]
            point++;
            if(winning_numbers[this_round][1] == my_numbers[this_round][msg.sender][1]) {
                point++;
                if(winning_numbers[this_round][2] == my_numbers[this_round][msg.sender][2]) {
                    point++;
                }
            }
        }

        if(point > 0) {
            address payable to = payable(msg.sender);
            to.transfer(point * winning_price);
        }else {
            revert("Not a winner");
        }
    }


}