// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

interface ERC20Interface {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256 balance);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool success);

    // function Transfer

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
}

contract sumoToken is ERC20Interface  {
    string public symbol;
    string public name;
    uint256 public decimals;
    uint256  _totalSupply;
    address public owner;

    event Approval(
        address indexed tokenowner,
        address indexed spender,
        uint256 tokens
    );
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;

    constructor() {
        symbol = "SNC";
        name = "Sumo Coin";
        decimals = 18;
        _totalSupply = 1_000_001_000_000_000_000_000_000;
        owner = msg.sender;
        balances[msg.sender] = _totalSupply; // balance who deploy
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256 balance) {
        return balances[account];
    }

    function transfer(address receiver, uint256 amount)
        public
        returns (bool success)
    {
        require(amount <= balances[msg.sender]);
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can run this function");
        _;
    }

    function mint(uint256 quantity) public onlyOwner returns (uint256) {
        _totalSupply += quantity;
        balances[msg.sender] += quantity;
        return _totalSupply;
    }

    function burn(uint256 quantity) public onlyOwner returns (uint256) {
        require(balances[msg.sender] >= quantity);
        _totalSupply -= quantity;
        balances[msg.sender] -= quantity;
        return _totalSupply;
    }

    function allowance(address _owner, address _spender)
        public
        view
        returns (uint256 remaining)
    {
        return allowed[_owner][_spender];
    }

    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        uint256 allowance1 = allowed[_from][msg.sender];
        require(balances[_from] >= _value && allowance1 >= _value);
        balances[_to] += _value;
        balances[_from] -= _value;
        allowed[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}
