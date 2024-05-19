// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract MultiSigWallet {
    event Deposit(address indexed sender, uint256 amount);
    event Submit(uint256 indexed txId);
    event Approve(address indexed owner, uint256 indexed txid);
    event Revoke(address indexed owner, uint256 indexed txid);
    event Execute(uint256 indexed txId);

    struct Transaction {
        address to;
        uint256 value;
        bytes data;
        bool executed;
    }

    address[] public owners;
    mapping(address => bool) isOwner;
    uint256 public required; // No. of owners that need to approve for executing tx

    Transaction[] public transactions;
    mapping(uint256 txIdx => mapping(address => bool)) public approved;

    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    modifier txExists(uint256 _txId) {
        require(_txId < transactions.length);
        _;
    }

    modifier notApproved(uint256 _txId) {
        require(!approved[_txId][msg.sender]);
        _;
    }

    modifier notExecuted(uint256 _txId) {
        require(!transactions[_txId].executed);
        _;
    }

    constructor(address[] memory _owners, uint256 _required) {
        require(_owners.length > 0, "Owners required");
        require(_required > 0 && _required <= _owners.length, "invalid required number of owners");

        for (uint256 i = 0; i < _owners.length; ++i) {
            address owner = _owners[i];

            require(owner != address(0), "invaild owner");
            require(!isOwner[owner], "owner is not unique");

            owners.push(owner);
            isOwner[owner] = true;
        }

        required = _required;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function submit(address _to, uint256 _value, bytes calldata _data) external onlyOwner {
        transactions.push(Transaction({to: _to, value: _value, data: _data, executed: false}));

        emit Submit(transactions.length - 1);
    }

    function approve(uint256 _txId) external onlyOwner txExists(_txId) notApproved(_txId) notExecuted(_txId) {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }

    function execute(uint256 _txId) external onlyOwner txExists(_txId) notExecuted(_txId) {
        uint256 numApprovals = 0;

        for (uint256 i = 0; i < owners.length; ++i) {
            if (approved[_txId][owners[i]]) {
                numApprovals++;
            }
        }

        require(numApprovals >= required, "approvals is less than requried");

        Transaction storage transaction = transactions[_txId];
        transaction.executed = true;
        (bool success,) = transaction.to.call{value: transaction.value}(transaction.data);

        require(success, "Tx failed");
        emit Execute(_txId);
    }

    /// The owner approves a tx but before it's executed, he changes his mind
    function revoke(uint256 _txId) external onlyOwner txExists(_txId) notExecuted(_txId) {
        require(approved[_txId][msg.sender], "tx not approved");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender, _txId);
    }
}
