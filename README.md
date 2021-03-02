# MatthewToken
> A fully-functioning ERC20 token based on the [Ethereum ERC20 Token Standard](https://eips.ethereum.org/EIPS/eip-20)

## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Setup](#setup)
* [Features](#features)
* [Status](#status)
* [Contact](#contact)

## General info
The purpose of this project was for me to understand the components and functionality of a ERC20 token contract.

## Technologies
* Truffle - v5.1.58
* Solidity - 0.8.1
* Node - v10.16.3
* Web3.js v1.2.9

## Setup
In order to demo this project, please do the following:
* `$ git clone`  this repository to your local machine 
Install [Truffle](https://www.trufflesuite.com/truffle) and [Ganache](https://www.trufflesuite.com/ganache) on your local machine
* Open Ganache and connect a workspace to the truffle-config.js file in the project directory
* In the project root directory, run `$ truffle migrate` to deploy the token contract to your Ganache local node
* Once the contract has successfully deployed, you can use Truffle's console to interact with the deployed contract

## Code Examples
Example of contract interaction via Truffle console:
* `let instance = await MatthewToken.deployed()`
* `instance.transferFrom('0x7D9D6fE36E1525dd0854BC9DFFFaA171580ABfFf', '0x8Af28DaeA7BBeEAF561695c5bAdCaa9163897f64', 1000)`

## Features
List of features ready:
* Query the total supply of tokens in circulation
* Query the balance of tokens that a given address owns
* Approve an address to spend a given amount of tokens on the contract owner's behalf
* Transfer tokens safely between addresses

## Status
Project is: _in progress_

## Contact
Created by [@matthewwatman](https://www.twitter.com/matthewwatman) - feel free to contact me!