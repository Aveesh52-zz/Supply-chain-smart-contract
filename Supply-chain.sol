pragma solidity ^4.23.0;


contract Logistic{
    
    address Owner;
    struct package{
        bool isuidgenerated;
        uint itemid;
        string itemname;
        string transitstatus;
        uint orderstatus; // 1 ordered 2 in transit 3 delivered 4 canceled
        
        address costumer;
        uint ordertime;
        
        address carrier1;
        uint carrier1_time;
        
        address carrier2;
        uint carrier2_time;
    
        address carrier3;
        uint carrier3_time;
    }

    
 mapping (address => package) public packagemapping;
 
 mapping (address => bool) public carriers;
 
 constructor() public{
     Owner = msg.sender;
 }
 
 
 modifier onlyOwner(){
   require(Owner == msg.sender);
   _;
 }
 
 function ManageCarriers(address _carrierAddress) onlyOwner public returns (string memory) {
     if(!carriers[_carrierAddress]){
         carriers[_carrierAddress] = true;
     } else {
         carriers[_carrierAddress] = false;
      return "Carrier status is updated";
 }

 }
 
 
 function OrderItem(uint _itemid, string memory _itemname) public returns (address) {
       
        address uniqueId = address(sha256(msg.sender,now));
        packagemapping[uniqueId].isuidgenerated = true;
        packagemapping[uniqueId].itemid = _itemid;
        packagemapping[uniqueId].itemname = _itemname;
        packagemapping[uniqueId].transitstatus = "The package is ordered and is under processing";
        packagemapping[uniqueId].orderstatus = 1;
        
        packagemapping[uniqueId].costumer = msg.sender;
        packagemapping[uniqueId].ordertime = now;

     return uniqueId;
 }

function CancelOrder(address _uniqueId) public returns (string memory){
    require(packagemapping[_uniqueId].isuidgenerated);
    require(packagemapping[_uniqueId].costumer == msg.sender);
    
    packagemapping[_uniqueId].orderstatus = 4;
    packagemapping[_uniqueId].transitstatus = "Your order status has been cancelled";
    
    return "Your order status has been cancelled successfully";
}

function Carrier1Report(address uniqueId,string memory _transitstatus) public{
    require(packagemapping[uniqueId].isuidgenerated);
    require(carriers[msg.sender]);
    require(packagemapping[uniqueId].orderstatus == 1);
    
    packagemapping[uniqueId].transitstatus = _transitstatus;
    packagemapping[uniqueId].carrier1 = msg.sender;
    packagemapping[uniqueId].carrier1_time = now;
    packagemapping[uniqueId].orderstatus = 1;
    
}


function Carrier2Report(address uniqueId,string memory _transitstatus) public{
    require(packagemapping[uniqueId].isuidgenerated);
    require(carriers[msg.sender]);
    require(packagemapping[uniqueId].orderstatus == 2);
    
    packagemapping[uniqueId].transitstatus = _transitstatus;
    packagemapping[uniqueId].carrier1 = msg.sender;
    packagemapping[uniqueId].carrier1_time = now;
 
    
}


function Carrier3Report(address uniqueId,string memory _transitstatus) public{
    require(packagemapping[uniqueId].isuidgenerated);
    require(carriers[msg.sender]);
    require(packagemapping[uniqueId].orderstatus == 2);
    
    packagemapping[uniqueId].transitstatus = _transitstatus;
    packagemapping[uniqueId].carrier1 = msg.sender;
    packagemapping[uniqueId].carrier1_time = now;
    packagemapping[uniqueId].orderstatus = 3;
    
}


    
    
}
