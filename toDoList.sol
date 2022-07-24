// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract toDoList{
    mapping (address => string[]) public todos;

    function addTodo(string memory _todo) public {

        todos[msg.sender].push(_todo);

    } 

    function getTodos() view public returns(string[] memory) {

        return todos[msg.sender];
    } 

    function getNumberOfTodos() view public returns(uint){

        return todos[msg.sender].length;
    }
    
    function deleteTodo(uint _index) public {

        require(_index <= getNumberOfTodos() , "Index doesn't exist!");

        todos[msg.sender][_index] = todos[msg.sender][getNumberOfTodos() - 1 ];
        todos[msg.sender].pop();

    } 

}