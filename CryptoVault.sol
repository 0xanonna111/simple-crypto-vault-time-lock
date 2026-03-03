// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CryptoVault
 * @dev A time-lock contract that holds funds until a specific date.
 */
contract CryptoVault {
    
    struct LockBox {
        uint256 balance;
        uint256 releaseTime;
    }

    mapping(address => LockBox) public vaults;

    event Deposited(address indexed user, uint256 amount, uint256 releaseTime);
    event Withdrawn(address indexed user, uint256 amount);

    /**
     * @dev Deposit funds into a time-locked vault.
     * @param _releaseTime The Unix timestamp when funds become available.
     */
    function deposit(uint256 _releaseTime) public payable {
        require(msg.value > 0, "Must deposit some ETH");
        require(_releaseTime > block.timestamp, "Release time must be in the future");

        vaults[msg.sender].balance += msg.value;
        vaults[msg.sender].releaseTime = _releaseTime;

        emit Deposited(msg.sender, msg.value, _releaseTime);
    }

    /**
     * @dev Withdraw funds after the release time has passed.
     */
    function withdraw() public {
        LockBox storage box = vaults[msg.sender];
        
        require(box.balance > 0, "No funds to withdraw");
        require(block.timestamp >= box.releaseTime, "Funds are still locked");

        uint256 amount = box.balance;
        box.balance = 0;

        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");

        emit Withdrawn(msg.sender, amount);
    }

    /**
     * @dev Helper to check time remaining in seconds.
     */
    function getTimeRemaining(address _user) public view returns (uint256) {
        if (block.timestamp >= vaults[_user].releaseTime) return 0;
        return vaults[_user].releaseTime - block.timestamp;
    }
}
