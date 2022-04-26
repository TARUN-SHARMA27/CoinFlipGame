/ SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;   //we are using antoher contract to crack into this contract

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract CoinFlip {

  using SafeMath for uint256;  //sate variables
  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968; //this is what is used for guessing a random number

  constructor() {
    consecutiveWins = 0;                    
  }

  function flip(bool _guess) public returns (bool) {       // notice that there is only one function. _guess is the value that will hold true or false will will judge the consectuive wins
           uint256 blockValue = uint256(blockhash(block.number.sub(1))); //every transaction the blockhash. global func and global vars here. blockhash func takes input of block number so u can get the hash number. block.number is current blo. you CANNOT get the hash of the current block that is being mined, so therefore we subrtract one in order to work with previous block number. mining takes time. this is how they generate their numbers for their algorithm. each coinflip is a transaction. using the same blockhas is what gives u the consistent consecutive wins.   
        
            if (lastHash == blockValue) {                 //lastHash declared as state var
              revert();                                  //this is what keeps us from hacking. it reverts any state changes
              }    
                    //if above not true, continue next block of code
            lastHash = blockValue;
            uint256 coinFlip = blockValue.div(FACTOR);
            bool side = coinFlip == 1 ? true : false;
        
            if (side == _guess) {
              consecutiveWins++;
              return true;       //add one if true
              } else {
              consecutiveWins = 0;     //set back to 0
              return false;
         }
      }
   }