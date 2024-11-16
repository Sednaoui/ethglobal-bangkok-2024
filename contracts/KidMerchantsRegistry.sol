// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract KidMerchantsRegistry {

    struct Entry {
        address target;
        string name;
        bytes32 description;
        bytes32 logo;
    }

    address public manager;
    mapping(bytes32 => Entry[]) public registry; // Category -> Entry[]

    constructor(address _manager) {
        manager = _manager;
    }

    function setManager(address _newManager) public {
        require(msg.sender == manager, "action not allowed");
        manager = _newManager;
    }

    function addEntry(bytes32 group, Entry calldata entry) public {
        require(msg.sender == manager, "action not allowed");
        registry[group].push(entry);
    }

    function getGroupEntries(bytes32 group) public view returns (Entry[] memory) {
        return registry[group];
    }

    function removeEntry(bytes32 group, uint256 index) public {
        require(msg.sender == manager, "action not allowed");
        Entry[] storage entries = registry[group];
        require(index < entries.length, "index out of range");
        entries[index] = entries[entries.length-1];
        entries.pop();
    }

}