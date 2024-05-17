
/**
 * Verification process TODO rewatch 
 * 
 * 0. Message
 * 1. Message hash
 * 
 * 2. Sign(Message hash, Private key) | offchain 
 * 3. ecrecover(Messahe hash, Signature) == signer
 */

import "lib/forge-std/src/Test.sol";

contract VerifySignature {

    error InvalidSignatureLength(uint invalidLength);

    function getMessageHash(string memory message) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(message));
    }

    function getEthMessageHash(bytes32 messageHash) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n32",
            messageHash
        ));
    }

    /**
     * sign - created by metamask offilne
     * ethereum.enable()
     * ethereum.request({ method: "personal_sign", params: [account, hash]}).then(console.log)
     */

    function verify(string memory message, bytes memory sign, address claimedSigner) public pure returns(bool) {
        bytes32 messageHash = getMessageHash(message);
        bytes32 ethMessageHash = getEthMessageHash(messageHash);
        address signer = recover(ethMessageHash, sign);
        console2.log("signer");
        console2.logAddress(signer);
        console2.log("claimedSigner");
        console2.logAddress(claimedSigner);
        return signer == claimedSigner;
    }

    function recover(bytes32 ethMessageHash, bytes memory sign) internal pure returns(address) {
        (bytes32 r, bytes32 s, uint8 v) = _split(sign);
        address recoveredAddress = ecrecover(ethMessageHash, v, r, s);
        return recoveredAddress;
    }


    function _split(bytes memory sign) internal pure returns(bytes32 r, bytes32 s, uint8 v) {

        if (sign.length != 65) {
            revert InvalidSignatureLength(sign.length);
        }

        assembly {
            r := mload(add(sign, 0x20))
            s := mload(add(sign, 0x40))
            v := byte(0, mload(add(sign, 0x60)))
        }

    }

}

/*//////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////*/

