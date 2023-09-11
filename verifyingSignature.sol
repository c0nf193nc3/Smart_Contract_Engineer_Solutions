// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract VerifySig {
    // Function to compute the hash of a given message.
    function getMessageHash(string memory _message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    // Function to compute the hash of a message following Ethereum's signing standards.
    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32) {
        // This is the actual hash that is signed, constructed as per Ethereum's signing standards.
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash));
    }

    // Function to split a signature into its components (r, s, v).
    function _split(bytes memory _sig) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(_sig.length == 65, "invalid signature length");

        assembly {
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96)))
        }
        // Implicitly return (r, s, v)
    }

    // Function to recover the signer's address from a message and its signature.
    function recover(bytes32 _ethSignedMessageHash, bytes memory _sig) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    // Function to verify a signature and check if it matches a given signer's address.
    function verify(address _signer, string memory _message, bytes memory _sig) public pure returns (bool) {
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return recover(ethSignedMessageHash, _sig) == _signer;
    }

    // A boolean state variable to track if a signature has been verified successfully.
    bool public signed;

    // Function to test a signature verification by checking if it matches the expected signer.
    function testSignature(address _signer, bytes memory _sig) external {
        string memory message = "secret";
        
        bytes32 messageHash = getMessageHash(message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);
        
        // Verify the signature against the expected signer's address.
        require(recover(ethSignedMessageHash, _sig) == _signer, "verify failed");
        
        // Set the 'signed' state variable to true to indicate a successful signature verification.
        signed = true;
    }
}




/* Let's break it down step by step:

The assembly block is used to write inline assembly code, which can access low-level operations directly.

r, s, and v are declared as local variables to store the components of the signature. These variables will hold the values extracted from _sig.

The require statement ensures that the length of the input _sig is exactly 65 bytes. Signatures in Ethereum are typically represented as 65 bytes (r, s, and v components combined).

Inside the assembly block:

mload is a special assembly operation used to load data from memory. It reads a 32-byte (256-bit) word from the specified memory location.
add is used to calculate memory offsets. In this case, it's used to point to the appropriate locations within the _sig byte array.
r := mload(add(_sig, 32)) loads the first 32 bytes of _sig (r component) into the r variable.

s := mload(add(_sig, 64)) loads the next 32 bytes of _sig (s component) into the s variable.

v := byte(0, mload(add(_sig, 96))) loads the 97th byte (offset 96, v component) of _sig into the v variable. The byte operation is used to extract the lowest 8 bits (1 byte) of the value.

Finally, the _split function implicitly returns (r, s, v) as a tuple.

*/
