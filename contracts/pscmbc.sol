// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract PSCMBC{
    struct Description{
        string drug_name;
        string drug_class;
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
        struct User{
        address user_id;
        string org_name;
        string user_type;
        string email;
        string password;
        uint balance;
        uint TIN;
        string location;
    }

    User[] public users;
    mapping (address => uint) public balances;

    event PaymentDone(
        address buyer,
        address seller,
        uint prodId,
        uint txnAmount,
        uint quantity,
        uint date
    );

    event UserCreated(
        address user_id,
        string org_name,
        string user_type,
        string email,
        string password,
        uint balance,
        uint TIN,
        string location
    );

    event ProductCreated(
        uint prod_id,
        address owner_id,
        string prod_name,
        uint price,
        uint avaiableUnits,
        Description prod_desc
    );

    constructor (address[] memory addr) payable{
        for(uint i = 0; i < addr.length; i++)
            balances[addr[i]] = 10000;
    }

    function getBalance()  public view returns (uint){
        return address(this).balance;
    }


    function create_user(string memory ut, string memory on, string memory email, string memory pass, uint bal, uint TIN, string memory loc) public {
        User memory u;
        u.user_id = msg.sender;
        u.org_name = on;
        u.email = email;
        u.password = pass;
        u.balance = bal;
        u.TIN=TIN;
        u.location = loc;
        u.user_type = ut;

        users.push(u);
        emit UserCreated(u.user_id, u.org_name, u.user_type, u.email, u.password, u.balance, u.TIN, u.location);
    }

    function buy_product(uint prodId, uint amount) public returns (bool bought){
        if(prodId != 0 && products[prodId].avaiableUnits >= amount){
            uint val = products[prodId].price * amount;
            if(!transferFund(products[prodId].owner_id, val))
                return false;
            products[prodId].avaiableUnits -= amount;
            create_prod(products[prodId].prod_name, products[prodId].price, amount, products[prodId].prod_desc.drug_name,
            products[prodId].prod_desc.drug_class, products[prodId].prod_desc.storage_temp, products[prodId].prod_desc.ingredients,
            products[prodId].prod_desc.mfg_date, products[prodId].prod_desc.exp_date, products[prodId].prod_desc.batch_no,
            products[prodId].prod_desc.sideEffects);            
            emit PaymentDone(msg.sender, products[prodId].owner_id, prodId, val, amount, block.timestamp);
            return true;
        }

        return false;
    } 

    function transferFund(address _to, uint256 _value) public returns (bool sufficient) {
        if(getBalance(msg.sender) >= _value){
            balances[msg.sender]-= _value;
            balances[_to]+=_value;
            return true;
        }
        return false;
    }

    function getBalance(address add) public view returns(uint){
        return balances[add];
    }

    function getProd(uint x) public view returns(Product memory p){
        return products[x];
    }

    function getBalance2(address addr) external view returns(uint){
        return addr.balance;
    }

    function create_prod (string memory pn, uint pr, uint au, string memory dn, string memory dc, 
    int st, string[] memory i, string[] memory md, string[] memory ed, string memory bn, string[] memory se) public {
        Product memory p;
        p.prod_id = products.length + 1;
        p.owner_id = msg.sender;
        p.prod_name = pn;
        p.price = pr;
        p.avaiableUnits = au;
        p.prod_desc.drug_name = dn;
        p.prod_desc.drug_class = dc;
        p.prod_desc.storage_temp = st;
        p.prod_desc.ingredients = i;
        p.prod_desc.mfg_date = md;
        p.prod_desc.exp_date = ed;
        p.prod_desc.batch_no = bn;
        p.prod_desc.sideEffects = se;

        products.push(p);
        emit ProductCreated(p.prod_id, p.owner_id, p.prod_name, p.price, p.avaiableUnits, p.prod_desc);
    }

    
}