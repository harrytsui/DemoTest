pragma solidity ^0.5.16;
import "./SafeMath.sol";

contract Tpsc{
  using SafeMath for uint256;

  event NewTask(string _taskname, string _taskInfo, string _taskRequire, string _taskDesc);

  struct Task {
    string taskname;//任务名称
    string taskInfo;//任务信息
    string taskRequire;//人员要求
    string taskDesc;//任务描述
  }

  mapping(address => Task) internal addressToTask;

  address public token;

  constructor() public payable {
    token = msg.sender;
  }

  // modifier onlyMemberOf(address _from) {
  //   require(addressToTask[_from].isExist);
  //   _;
  // }

  // 注册
  function addTask(string memory  _taskname, string memory  _taskInfo, string memory  _taskRequire, string memory  _taskDesc) public {
    //require(!isMemberOf());
    addressToTask[msg.sender] = Task(_taskname, _taskInfo, _taskRequire, _taskDesc);
    emit NewTask(_taskname, _taskInfo, _taskRequire, _taskDesc);
  }

  // 判断是否注册
  // function isMemberOf() public view returns (bool) {
  //  return addressToTask[msg.sender].isExist;
  //}

  // 获取任务信息
  function getTaskInfo() public view returns (string memory  _taskname, string memory  _taskInfo, string memory  _taskRequire, string memory  _taskDesc) {
    return (addressToTask[msg.sender].taskname, addressToTask[msg.sender].taskInfo, addressToTask[msg.sender].taskRequire, addressToTask[msg.sender].taskDesc);
  }

  // function getTotalBalance() public view returns (uint256) {
  //   return address(this).balance;
  // }

  // function withdraw(uint256 amount) public returns (uint256) {
  //   require(address(this).balance >= amount);
  //   addressToTask[msg.sender].balance = addressToTask[msg.sender].balance.sub(amount);
  //   msg.sender.transfer(amount);
  //   return addressToTask[msg.sender].balance;
  // }
}