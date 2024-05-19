// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "lib/forge-std/src/Test.sol";
import "../new/Sig.sol";

contract SigTest is Test {
    VerifySignature public v;

    function setUp() external {
        v = new VerifySignature();
    }

    function testSig() public {
        bytes32 msgHash = v.getMessageHash("Ethereum is awesome !");
        console2.logBytes32(msgHash); // 0xe1c14908f19e6bad2d29f9b077dff81c63929248c71c5a6e5ad6fc481694ccbe
        bytes32 ethMessageHash = v.getEthMessageHash(msgHash);

        /*
        * sign - created by metamask offilne
        * ethereum.enable()
        * ethereum.request({ method: "personal_sign", params: [account, hash]}).then(console.log)
        * ethereum.request({ method: "personal_sign", params: ["0xE65a687748A2A86b9B6e4E290709B665FD1781F5", "0xe1c14908f19e6bad2d29f9b077dff81c63929248c71c5a6e5ad6fc481694ccbe"]}).then(console.log)
        */

        bytes memory sign = abi.encodePacked(
            hex"d11793a17f33dd88d0a1b0331628f482b24e6b7b3cba3d3d5144127d908ef7f33ba4738b889853d38911b73e129df2756a8162ce7bb5a18b004afb772946b45a1b"
        );
        bool success = v.verify("Ethereum is awesome !", sign, 0xE65a687748A2A86b9B6e4E290709B665FD1781F5);
        assertEq(success, true);
    }
}
