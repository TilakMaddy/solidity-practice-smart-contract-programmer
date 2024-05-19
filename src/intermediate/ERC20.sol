// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "lib/forge-std/src/interfaces/IERC20.sol";

contract ERC20 is IERC20 {
    uint256 s_totalTokens;
    mapping(address account => uint256 tokens) s_tokens;
    mapping(address owner => mapping(address spender => uint256)) s_allowances;
    address immutable s_owner;

    constructor() {
        s_totalTokens = 1000 * (10 ** 18);
        s_tokens[msg.sender] = 1000 * (10 ** 18);
        s_owner = msg.sender;
    }

    /// @inheritdoc IERC20
    function totalSupply() external view returns (uint256) {
        return s_totalTokens;
    }

    /// @inheritdoc IERC20
    function balanceOf(address account) external view returns (uint256) {
        return s_tokens[account];
    }

    /// @inheritdoc IERC20
    function transfer(address to, uint256 amount) external returns (bool) {
        uint256 existingAmount = s_tokens[msg.sender];
        if (amount > existingAmount) {
            return false;
        }
        s_tokens[msg.sender] -= amount;
        s_tokens[to] += amount;

        emit Transfer(msg.sender, to, amount);

        return true;
    }

    /// @inheritdoc IERC20
    function allowance(address owner, address spender) external view returns (uint256) {
        return s_allowances[owner][spender];
    }

    /// @inheritdoc IERC20
    function approve(address spender, uint256 amount) external returns (bool) {
        s_allowances[msg.sender][spender] = amount;
        return true;
    }

    /// @inheritdoc IERC20
    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        if (amount > s_allowances[from][to] || amount > s_tokens[from]) {
            return false;
        }
        s_tokens[from] -= amount;
        s_tokens[to] += amount;
        s_allowances[from][to] -= amount;

        emit Transfer(from, to, amount);

        return true;
    }

    /// @inheritdoc IERC20
    function name() external pure returns (string memory) {
        return "Tilak's ERC20";
    }

    /// @inheritdoc IERC20
    function decimals() external pure returns (uint8) {
        return 18;
    }

    /// @inheritdoc IERC20
    function symbol() external pure returns (string memory) {
        return "TERC";
    }

    function mint(uint256 tokens) external {
        require(msg.sender == s_owner, "only owner can mint");
        s_totalTokens += tokens;
        s_tokens[msg.sender] += tokens;

        emit Transfer(address(0), msg.sender, tokens);
    }

    function burn(uint256 tokens) external {
        s_tokens[msg.sender] -= tokens;
        s_totalTokens -= tokens;

        emit Transfer(msg.sender, address(0), tokens);
    }
}

/**
 * Custom functions - mint, burn
 * (Not part of ERC20 standard)
 *
 */
