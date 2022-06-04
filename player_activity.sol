// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";


contract Player is Ownable {
    struct CreatePlayer{
    uint Id;
    string Name;
    address Address;
}
uint public playerCount;
mapping(uint=> CreatePlayer) public playerMapping;
mapping(address=> bool) public addWhiteListAddress;


event addingNewPlayer(
    uint Id,
    address Address
); 

event updateplayer(
uint _Id,
string Name,
address _address
);

event AddedWhiteListAddress(
address addWhitelistedAddress,
address addedBy
);

event RemoveWhiteListAddress(
address addWhitelistedAddress,
address addedBy
);

modifier isWhiteListed(){
require(addWhiteListAddress[msg.sender],"Unauthorized Address");
_;
}


function addWhiteListedAddress(address addWhitelistedAddress)external onlyOwner{
 require(!addWhiteListAddress[addWhitelistedAddress],"already selected address by owner");
 addWhiteListAddress[addWhitelistedAddress] = true;

emit AddedWhiteListAddress(addWhitelistedAddress,msg.sender);
}
function removeWhiteListedAddress(address addWhitelistedAddress)external onlyOwner{
 require(!addWhiteListAddress[addWhitelistedAddress],"already selected address by owner");
 addWhiteListAddress[addWhitelistedAddress] = false;
emit RemoveWhiteListAddress(addWhitelistedAddress,msg.sender);
}

function createNewPlayer(
    uint _Id, string memory _Name,address _Address
    )external
    isWhiteListed
    {
        playerCount++;
        playerMapping[playerCount]=CreatePlayer(_Id, _Name, _Address);
        emit addingNewPlayer(playerCount,_Address);
}

function Update(
    uint _Id, string memory _Name,address _Address
    )external isWhiteListed
{
 playerMapping[_Id].Name=_Name;
playerMapping[_Id].Address=_Address;
 playerCount++;
 emit addingNewPlayer(playerCount,_Address);
}

function getPlayerInfo(uint _id)external view returns(CreatePlayer memory){
    return playerMapping[_id];
}

}