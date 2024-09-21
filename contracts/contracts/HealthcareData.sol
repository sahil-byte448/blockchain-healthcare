// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HealthcareData {
    address public owner;
    mapping(address => bool) private providers;
    mapping(address => string) private patientData;

    event DataShared(address indexed patient, address provider);
    event ProviderApproved(address provider);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    function approveProvider(address _provider) public onlyOwner {
        providers[_provider] = true;
        emit ProviderApproved(_provider);
    }

    function storeData(address patient, string memory data) public onlyOwner {
        patientData[patient] = data;
    }

    function shareData(address patient, address provider) public view returns (string memory) {
        require(providers[provider], "Provider not approved");
        return patientData[patient];
    }
}
