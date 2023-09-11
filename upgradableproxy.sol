
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./StorageSlot.sol";

contract TransparentUpgradeableProxy {
    // Define storage slots to store the address of admin and implementation contract
    bytes32 private constant IMPLEMENTATION_SLOT =
        bytes32(uint(keccak256("eip1967.proxy.implementation")) - 1);
    bytes32 private constant ADMIN_SLOT =
        bytes32(uint(keccak256("eip1967.proxy.admin")) - 1);

    // Modifier that checks if the caller is the admin
    modifier ifAdmin() {
        // Check if the caller is the admin, if yes, proceed with the function; otherwise, delegate the call to the implementation contract
        if (msg.sender == _getAdmin()) {
            _;
        } else {
            _delegate(_getImplementation());
        }
    }

    // Fallback function to delegate calls to the implementation contract
    fallback() external payable {
        _delegate(_getImplementation());
    }

    // Receive function to delegate calls to the implementation contract
    receive() external payable {
        _delegate(_getImplementation());
    }

    // Use the library StorageSlot to get the address of the admin stored at ADMIN_SLOT
    function _getAdmin() private view returns (address) {
        StorageSlot.AddressSlot storage data = StorageSlot.getAddressSlot(
            ADMIN_SLOT
        );
        return data.value;
    }

    // Require that _admin is not the zero address and set the admin address in ADMIN_SLOT using StorageSlot
    function _setAdmin(address _admin) private {
        require(_admin != address(0), "admin = zero address");
        StorageSlot.getAddressSlot(ADMIN_SLOT).value = _admin;
    }

    // Get the address of the implementation contract from IMPLEMENTATION_SLOT using StorageSlot
    function _getImplementation() private view returns (address) {
        return StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value;
    }

    // Set the implementation contract address in IMPLEMENTATION_SLOT using StorageSlot
    function _setImplementation(address _impl) private {
        require(_impl.code.length > 0, "not a contract");
        StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value = _impl;
    }

    // Constructor sets the contract deployer as the admin
    constructor() {
        _setAdmin(msg.sender);
    }

    // Change the admin address, can only be called by the current admin
    function changeAdmin(address _admin) external ifAdmin {
        _setAdmin(_admin);
    }

    // Upgrade to a new implementation contract, can only be called by the current admin
    function upgradeTo(address _impl) external ifAdmin {
        _setImplementation(_impl);
    }

    // Get the admin address, can only be called by the current admin
    function admin() external ifAdmin returns (address) {
        return _getAdmin();
    }

    // Get the implementation contract address, can only be called by the current admin
    function implementation() external ifAdmin returns (address) {
        return _getImplementation();
    }

    // Internal function to delegate calls to the implementation contract using inline assembly
    function _delegate(address _implementation) internal {
        assembly {
            // Copy msg.data. We take full control of memory in this inline assembly
            // block because it will not return to Solidity code. We overwrite the
            // Solidity scratch pad at memory position 0.

            // calldatacopy(t, f, s) - copy s bytes from calldata at position f to mem at position t
            // calldatasize() - size of call data in bytes
            calldatacopy(0, 0, calldatasize())

            // Call the implementation.
            // out and outsize are 0 because we don't know the size yet.

            // delegatecall(g, a, in, insize, out, outsize) -
            // - call contract at address a
            // - with input mem[in…(in+insize))
            // - providing g gas
            // - and output area mem[out…(out+outsize))
            // - returning 0 on error (eg. out of gas) and 1 on success
            let result := delegatecall(
                gas(),
                _implementation,
                0,
                calldatasize(),
                0,
                0
            )

            // Copy the returned data.
            // returndatacopy(t, f, s) - copy s bytes from returndata at position f to mem at position t
            // returndatasize() - size of the last returndata
            returndatacopy(0, 0, returndatasize())

            switch result
            // delegatecall returns 0 on error.
            case 0 {
                // revert(p, s) - end execution, revert state changes, return data mem[p…(p+s))
                revert(0, returndatasize())
            }
            default {
                // return(p, s) - end execution, return data mem[p…(p+s))
                return(0, returndatasize())
            }
        }
    }
}
/*
Now, let's explain each part of the code:

1. The contract begins with SPDX license information and specifies the Solidity version.

2. It imports the `StorageSlot.sol` library, which is used to manage storage slots efficiently.

3. Two private constant variables, `IMPLEMENTATION_SLOT` and `ADMIN_SLOT`, are defined to represent storage slots for the implementation contract address and the admin address, respectively.

4. The `ifAdmin` modifier checks if the caller is the admin. If yes, it proceeds with the function; otherwise, it delegates the call to the implementation contract.

5. The `fallback` and `receive` functions are used to delegate calls to the implementation contract when no specific function matches the call data.

6. Several private functions (`_getAdmin`, `_setAdmin`, `_getImplementation`, and `_setImplementation`) are defined to interact with storage slots using the `StorageSlot` library. These functions are used to read and set the admin and implementation contract addresses.

7. The constructor sets the deployer of the contract as the initial admin.

8. The `changeAdmin` function allows the current admin to change the admin address.

9. The `upgradeTo` function allows the current admin to upgrade to a new implementation contract.

10. The `admin` function returns the current admin address, and the `implementation` function returns the address of the implementation contract. Both can only be called by the current admin.

11. The `_delegate` function is an internal function that uses inline assembly to delegate calls to the implementation contract. It copies the call data, performs the delegate call, and handles the returned data.

In summary, this code implements a transparent upgradeable proxy contract that allows the admin to change the underlying implementation contract while preserving the proxy's address. It uses storage slots efficiently to store the admin and implementation contract addresses and delegates calls to the implementation contract using inline assembly. The proxy contract provides a secure and upgradeable way to manage contract logic.
*/