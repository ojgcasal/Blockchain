// SPDX-License-Identifier: Unlicenced
pragma solidity 0.8.30;
contract TokenContract {
    address public owner;
    struct Receivers {
        string name;
        uint256 tokens;
    }
    mapping(address => Receivers) public users;
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    constructor() {
        owner = msg.sender;
        users[owner].tokens = 100;
    }
    function double(uint _value) public pure returns (uint) {
        return _value * 2;
    }
    function register(string memory _name) public {
        users[msg.sender].name = _name;
    }
    function giveToken(address _receiver, uint256 _amount) public onlyOwner {
        require(users[owner].tokens >= _amount);
        users[owner].tokens -= _amount;
        users[_receiver].tokens += _amount;
    }
    function buyTokens() public payable returns (uint256) {
    uint256 price = 5 ether;
    require(msg.value >= price, "No se envio suficiente Ether, 1 Token = 5 Ether");
    uint256 tokensToBuy = msg.value / price;
    require(users[owner].tokens >= tokensToBuy, "Owner sin suficientes tokens");
    users[owner].tokens -= tokensToBuy;
    users[msg.sender].tokens += tokensToBuy;
    return address(this).balance;
}
}
