
# Project Overview
This repository contains a collection of Solidity contracts demonstrating fundamental blockchain programming concepts. The project is designed for developers learning Ethereum smart contract development, covering essential topics such as:
- Basic contract structure
- State variables
- Functions
- Events
- Error handling
- Security best practices

## Installation
To work with this project, you'll need:

### Prerequisites
- Node.js (>=16.0.0)
- npm or yarn
- Solidity compiler (solc) , Remix
- Hardhat or Truffle Suite (optional)

- ## Key Concepts
The project demonstrates several fundamental Solidity concepts:

### 1. Contract Structure
- Basic contract declaration
- Constructor functions
- State variable types
- Function modifiers

### 2. Data Types
- Value types (uint, bool, address)
- Reference types (arrays, mappings)
- Complex types (structs, enums)

### 3. Functions
- View and pure functions
- Modifiers
- Events
- Error handling
## Examples
- // I'm a comment!
// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

// pragma solidity ^0.8.0;
// pragma solidity >=0.8.0 <0.9.0;

contract SimpleStorage {
    uint256 myFavoriteNumber;
    struct Person {
        uint256 favoriteNumber;
        string name;
    }
    // uint256[] public anArray;
    Person[] public listOfPeople;
    mapping(string => uint256) public nameToFavoriteNumber;
    function store(uint256 _favoriteNumber) public virtual {
        myFavoriteNumber = _favoriteNumber;
    }
    function retrieve() public view returns (uint256) {
        return myFavoriteNumber;
    }
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
