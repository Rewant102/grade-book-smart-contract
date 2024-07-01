// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GradeBook {
    address public owner;
    
    struct Grade {
        string studentName;
        string subject;
        uint grade;
    }
    
    Grade[] public grades;
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function.");
        _;
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    function addGrade(string memory _studentName, string memory _subject, uint _grade) public onlyOwner {
        grades.push(Grade(_studentName, _subject, _grade));
    }
    
    function updateGrade(uint index, uint _grade) public onlyOwner {
        require(index < grades.length, "Grade index out of bounds.");
        grades[index].grade = _grade;
    }
    
    function getGrade(uint index) public view returns (string memory, string memory, uint) {
        require(index < grades.length, "Grade index out of bounds.");
        Grade memory grade = grades[index];
        return (grade.studentName, grade.subject, grade.grade);
    }
    
    function averageGrade(string memory _subject) public view returns (uint) {
        uint total = 0;
        uint count = 0;
        
        for (uint i = 0; i < grades.length; i++) {
            if (keccak256(bytes(grades[i].subject)) == keccak256(bytes(_subject))) {
                total += grades[i].grade;
                count++;
            }
        }
        
        if (count > 0) {
            return total / count;
        } else {
            return 0;
        }
    }
}
