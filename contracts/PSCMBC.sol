// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract PSCMBC{
   /* struct Description{
        string drug_name;
        string drug_class;
        //uint weigth;
        int storage_temp;
        string[] ingredients;
        string[] mfg_date;
        string[] exp_date;
        string batch_no;
        string[] sideEffects;
    }
    
    struct Product{
        uint prod_id;
        address owner_id;
        string prod_name;
        uint price;
        uint avaiableUnits;
        Description prod_desc;
    }

    Product[] public products;
*/
    mapping (address => uint) public balances;

    constructor(address[] memory addr) payable{
        for(uint i = 0; i < addr.length; i++)
            balances[addr[i]] = 1000;
    }

    //recieve() external payable{}

    function getBalance()  external view returns (uint){
        return address(this).balance;
    }

    function getBalance(address add) public view returns(uint){
        return balances[add];
    }
}