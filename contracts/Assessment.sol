// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Assessment {
    address public owner;
    uint256 public ethBalance;
    uint256 public ethToInrRate;

    event EtherDeposited(address indexed depositor, uint256 amount);
    event EtherWithdrawn(address indexed withdrawer, uint256 amount);
    event ConversionRateUpdated(uint256 newRate);

    constructor(uint256 initEthBalance, uint256 initEthToInrRate) payable {
        owner = msg.sender;
        ethBalance = initEthBalance;
        ethToInrRate = initEthToInrRate;
    }

    function getEthBalance() public view returns (uint256) {
        return ethBalance;
    }

    function getEthToInrRate() public view returns (uint256) {
        return ethToInrRate;
    }

    function depositEther() public payable {
        ethBalance += msg.value;
        emit EtherDeposited(msg.sender, msg.value);
    }

    function withdrawEther(uint256 _amount) public {
        require(_amount <= ethBalance, "Insufficient balance");
        ethBalance -= _amount;
        payable(msg.sender).transfer(_amount);
        emit EtherWithdrawn(msg.sender, _amount);
    }

    function updateEthToInrRate(uint256 _newRate) public {
        require(msg.sender == owner, "Only owner can update conversion rate");
        ethToInrRate = _newRate;
        emit ConversionRateUpdated(_newRate);
    }

    function getEthBalanceInInr() public view returns (uint256) {
        return ethBalance * ethToInrRate;
    }
}

