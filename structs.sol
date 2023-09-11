// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract StructExamples {
    // Declaring a Solidity smart contract named "StructExamples."

    struct Car {
        string model;
        uint year;
        address owner;
    }
    // Defining a struct named "Car" that represents a car with three fields: model (string), year (uint), and owner (address).

    Car[] public cars;
    // Declaring a public dynamic array of "Car" structs to store information about cars.

    function examples() public {
        // A public function named "examples" that demonstrates various operations with structs and arrays.

        Car memory toyota = Car("Toyota", 1980, msg.sender);
        // Initializing a "Car" struct named "toyota" with values.
        // This is the first way to initialize a struct in Solidity.

        Car memory lambo = Car({
            model: "Lamborghini",
            year: 1999,
            owner: msg.sender
        });
        // Initializing a "Car" struct named "lambo" using named arguments.
        // This is the second way to initialize a struct.

        Car memory tesla;
        tesla.model = "Tesla";
        tesla.year = 2020;
        tesla.owner = msg.sender;
        // Initializing a "Car" struct named "tesla" by assigning values to its fields individually.
        // This is the third way to initialize a struct.

        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);
        // Adding the "toyota," "lambo," and "tesla" structs to the "cars" array.

        cars.push(Car("Ferrari", 2000, msg.sender));
        // Initializing a "Car" struct inline and pushing it directly to the "cars" array.

        Car storage car = cars[0];
        // Creating a reference "car" to the first element (index 0) of the "cars" array.

        car.year = 1988;
        // Modifying the "year" field of the referenced "car" struct.
    }

    function register(string memory _model, uint _year) public {
        // A public function named "register" that allows registering a new car in the "cars" array.

        cars.push(Car({model: _model, year: _year, owner: msg.sender}));
        // Initializing a new "Car" struct with provided values and pushing it to the "cars" array.
    }

    function get(uint _index) public view returns (string memory model, uint year, address owner) {
        // A public view function named "get" that retrieves information about a car at a specified index.

        return (cars[_index].model, cars[_index].year, cars[_index].owner);
        // Returning the model, year, and owner of the car at the specified index.
    }

    function transfer(uint _index, address _owner) external {
        // A public function named "transfer" that allows changing the owner of a car at a specified index.

        cars[_index].owner = _owner;
        // Updating the owner of the car at the specified index to the provided address "_owner."
    }
}