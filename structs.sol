// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title StructExamples
 * @dev This contract demonstrates the use of structs and arrays in Solidity.
 */
contract StructExamples {
    struct Car {
        string model;
        uint year;
        address owner;
    }
    
    Car[] public cars;

    /**
     * @dev Demonstrates various operations with structs and arrays.
     */
    function examples() public {
        Car memory toyota = Car("Toyota", 1980, msg.sender);
        Car memory lambo = Car({
            model: "Lamborghini",
            year: 1999,
            owner: msg.sender
        });
        Car memory tesla;
        tesla.model = "Tesla";
        tesla.year = 2020;
        tesla.owner = msg.sender;

        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);
        cars.push(Car("Ferrari", 2000, msg.sender));

        Car storage car = cars[0];
        car.year = 1988;
    }

    /**
     * @dev Allows registering a new car in the "cars" array.
     * @param _model The model of the car.
     * @param _year The year the car was manufactured.
     */
    function register(string memory _model, uint _year) public {
        cars.push(Car({model: _model, year: _year, owner: msg.sender}));
    }

    /**
     * @dev Retrieves information about a car at a specified index.
     * @param _index The index of the car to retrieve.
     * @return model The model of the car.
     * @return year The year the car was manufactured.
     * @return owner The current owner of the car.
     */
    function get(uint _index) public view returns (string memory model, uint year, address owner) {
        return (cars[_index].model, cars[_index].year, cars[_index].owner);
    }

    /**
     * @dev Allows changing the owner of a car at a specified index.
     * @param _index The index of the car to transfer ownership.
     * @param _owner The new owner's address.
     */
    function transfer(uint _index, address _owner) external {
        cars[_index].owner = _owner;
    }
}
