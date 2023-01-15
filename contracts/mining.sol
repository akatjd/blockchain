// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract mining {

    uint8 constant _decimals = 18;

    ERC20 token = ERC20(0xb8A1dab4faa26a93f25e3003214A06061e2B938B);
    ERC721 my_nft = ERC721(0x275CceD6405b06F2DbBB3b319831D95Ef13EdE83);

    // ex 70 -> 821211 블록
    // ex 91 -> 821100 블록
    // ex 190 -> 700780 블록
    // 각 nft id 별로 맵핑
    mapping(uint256 => uint256) last_block;

    function do_mine(uint256 nft_id) public {
        if(my_nft.ownerOf(nft_id) == msg.sender) {
            if(last_block[nft_id] == 0) {
                last_block[nft_id] = block.number;
            }else {
                uint256 amount = block.number - last_block[nft_id];
                last_block[nft_id] = block.number;

                // 요청 주소에 지정한 토큰 컨트렉 approve 시켜줌
                token.approve(address(this), amount * 10**_decimals);

                // 해당 컨트렉에서 메시지 보내는 쪽으로 토큰을 amount만큼 보냄
                token.transferFrom(address(this), msg.sender, amount * 10**_decimals);
            }
        }else {
            // do nothing..
        }
    }
}