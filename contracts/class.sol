// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

contract FirstClass {

    // uint count = 3;
    string str = "satoshi give me an answer !";
    uint count = 77;

    // read contract
    function my_function01() public view returns(string memory){
        return str;
    }

    // read contract
    function my_function02() public view returns(uint){
        return count;
    }

    // write contract
    function my_function03() public{
        count = count + 1;
    }

    // write contract
    function my_function03(string memory added_txt) public{
        // 홀더 인증을 붙여서 내 NFT인지 확인할 수 는 기능으로 사용할 수 있음
        str = string.concat(str, added_txt);
    }
}