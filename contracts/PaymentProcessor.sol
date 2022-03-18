// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract PaymentProcessor {

        struct Description{
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

    mapping (address => uint) public balances;
    
    constructor(uint amount) {
        balances[msg.sender] = amount;
    }

    function addBalance(address add,uint amount) public{
        balances[add] += amount;
    }

    function pay(address reciever, uint amount) public returns (bool sufficient) {
        if(balances[msg.sender] < amount) return false;
        balances[msg.sender] -= amount;
        balances[reciever] += amount;
        return true;
    }

    /*function transfer(address _to, uint256 _value) public returns (bool sufficient) {

    }*/

    function getBalance(address add) public view returns(uint){
        return balances[add];
    }

    function getBalance2(address addr) external view returns(uint){
        return addr.balance;
    }

    function create_prod (string memory pn, uint pr, uint au, string memory dn, string memory dc, int st, string[] memory i, string[] memory md, string[] memory ed, string memory bn, string[] memory se) public {
        Product memory p;
        p.prod_id = products.length + 1;
        p.owner_id = msg.sender;
        p.prod_name = pn;
        p.price = pr;
        p.avaiableUnits = au;
        p.prod_desc.drug_name = dn;
        p.prod_desc.drug_class = dc;
      //  p.prod_desc.weigth = w;
        p.prod_desc.storage_temp = st;
        p.prod_desc.ingredients = i;
        p.prod_desc.mfg_date = md;
        p.prod_desc.exp_date = ed;
        p.prod_desc.batch_no = bn;
        p.prod_desc.sideEffects = se;

        products.push(p);
    }

    function getProd(uint x) public view returns(Product memory p){
        return products[x];
    }
}
