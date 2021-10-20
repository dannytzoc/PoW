// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract PoE{
    event ProofCreated(uint256 indexed id , bytes32 documentHash);
    address public owner;
    mapping (uint256 => bytes32) hashesById;
    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner is allwoed to access this function");
        _;
    } 
    modifier noHashExistYet(uint256 id){
    require(hashesById[id]=="","No hash exists for this id.");
    _;
    }
    constructor(){
        owner = msg.sender;
    }
    function notarizeHash(uint256 id, bytes32 documentHash) public onlyOwner noHashExistYet(id){
        hashesById[id]= documentHash;
        emit ProofCreated(id, documentHash);
    }

    function doesProofExist(uint256 id, bytes32 documentHash) public view returns(bool){
        return hashesById[id]== documentHash;
    }

}