// SPDX-License-Identifier: UNLICENSED 
pragma solidity 0.8.19;

contract Proxy {

    error DeploymentFailed();

    function deploy(bytes memory code) external returns (address addr) {
        assembly {
            addr := create(
                callvalue(),    // msg.value 
                add(code, 0x20),
                mload(code)
            )
        }
        if (addr == address(0)) {
            revert DeploymentFailed();
        }
    }

    function interact(address target, bytes calldata data) external payable {
        (bool success, ) = target.call{value: msg.value}(data);
        if (!success) {
            revert();
        }
    } 

}

contract Test1 {
    function test1() external pure {

    }
}

contract Test2 {
    constructor(uint a, uint b) {

    }

     function test2() external pure {

    }
}


contract Deployer {
    function execute(address proxy) external {
        bytes memory code = type(Test1).creationCode;
        address dc = Proxy(proxy).deploy(code);

        bytes memory data = abi.encodeWithSignature("test1()");
        Proxy(proxy).interact(dc, data);

        // Create the deployment code by concatenating creationcode 
        // with constructor arguments
        bytes memory temp = type(Test2).creationCode;
        bytes memory code2 = abi.encodePacked(temp, abi.encode(3, 4));
        address dc2 = Proxy(proxy).deploy(code2);

        bytes memory data2 = abi.encodeWithSignature("test2()");
        Proxy(proxy).interact(dc2, data2);
    }
}
