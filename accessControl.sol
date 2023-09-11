// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract AccessControl {
    // Event to log when a role is granted to an account.
    event GrantRole(bytes32 indexed role, address indexed account);
    // Event to log when a role is revoked from an account.
    event RevokeRole(bytes32 indexed role, address indexed account);

    // Mapping to store role assignments. Maps roles to accounts with a boolean indicating whether the account has the role.
    mapping(bytes32 => mapping(address => bool)) public roles;

    // Constants defining role names as keccak256 hashes of strings.
    bytes32 public constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    bytes32 public constant USER = keccak256(abi.encodePacked("USER"));
    
    // Constructor to grant the ADMIN role to the contract deployer.
    constructor() {
        _grantRole(ADMIN, msg.sender);
    }
    
    // Modifier to restrict access to functions based on roles.
    modifier onlyRole(bytes32 _role) {
        // Require that the caller has the specified role, otherwise raise an "access denied" error.
        require(roles[_role][msg.sender], "access denied");
        _; // Continue with the function execution if the requirement is met.
    }

    // Internal function to grant a role to an account.
    function _grantRole(bytes32 _role, address _account) internal {
        // Set the role mapping to true for the specified account.
        roles[_role][_account] = true;
        // Emit an event to log the role grant.
        emit GrantRole(_role, _account);
    }

    // Function to grant a role to an account (only accessible by ADMIN).
    function grantRole(bytes32 _role, address _account) external onlyRole(ADMIN) {
        // Call the internal _grantRole function to perform the role grant.
        _grantRole(_role, _account);
    }

    // Function to revoke a role from an account (only accessible by ADMIN).
    function revokeRole(bytes32 _role, address _account) external onlyRole(ADMIN)  {
        // Delete the role mapping for the specified account, effectively revoking the role.
        delete roles[_role][_account];
        // Emit an event to log the role revocation.
        emit RevokeRole(_role, _account);
    }
}
