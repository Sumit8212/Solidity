// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract test{
mapping(string => mapping(string => uint)) grades;

function setGrade(string memory course, string memory student, uint grade) public {
    grades[course][student] = grade;
}

function getGrade(string memory course, string memory student) public view returns (uint) {
    return grades[course][student];
}
}