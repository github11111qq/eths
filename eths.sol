contract ETHS {
 
struct  Player {

    uint256 pID; 
    address payable addr; 
    uint256 affId; 
    uint256 totalBet; 
    uint256 curGen; 
    uint256 curAff;
    uint256 lastBet; 
    uint256 lastReleaseTime;
    bool    isaffer; 
    uint256 affToltalBet;
    uint256 createTime;
    uint256 baseGen;
    uint256 baseAff;
    uint256 baseAffed;
}

struct levelReward {    
    uint256 genRate; 
    uint256 deepAff;

}


 uint256  private minbeteth_ = 1 * ethWei;   
 uint256 constant private getoutBeishu = 3; 
 uint256 public nextId_ = 1;                         
 uint256  genReleTime_ = 24  hours;  
 bool public activated_ = true;     
 mapping (address => uint256)   public pIDxAddr_;  
 mapping (uint256 => Player)    public plyr_; 
 mapping (uint256 => playerReward) public plyrReward_;
 mapping (uint256 => levelReward) public levelReward_; 
 mapping (uint256 => withdrawSet) public withDrawSet_;
 mapping (uint256 => playerPot) public playerPot_;
 mapping (uint256 => uint256[]) public betMaxId_; 
 mapping (uint256 => uint256[]) public luckyId_;
 mapping (uint256 => uint256[]) public bestDongtaiBaseUser_;
 mapping (uint256 => mapping(uint256 => uint256)) public affBijiao_;
 uint256 public gBet_ = 0 ;
 uint256 public gWithDraw_ = 0;
 uint256 public gBetcc_ =0;


uint256[30] affRate = [400,200,100,50,50,50,50,50,50,50,30,30,30,30,30,10,10,10,10,10,5,5,5,5,5,5,5,5,5,5];
 
uint256 public luckyPot_ = 0;
uint256 public openLuckycc_ = 100;
uint256  public  luckyRound_ = 1;

uint256 public Pot_ = 0;
uint256 public PotDaoshuTime_ = 240 hours;
uint256 public StartTime_ = 0;
uint256  public  zRound_ = 1;

uint256 public totalCoin = 0;


modifier isActivated() {
    require(activated_ == true, "its not ready yet.  check ?eta in discord");
    _;
}

modifier isHuman() {
    address _addr = msg.sender;
    uint256 _codeLength;

    assembly {_codeLength := extcodesize(_addr)}
    require(_codeLength == 0, "sorry humans only");
    _;
}

modifier isWithinLimits(uint256 _eth) {
    require(_eth >= minbeteth_, "pocket lint: not a valid currency");
    require(_eth <= 100000000000000000000000, "no vitalik, no");
    _;
}

constructor()
public
{
    levelReward_[1] = levelReward(6,1);
    levelReward_[2] = levelReward(8,10);
    levelReward_[3] = levelReward(10,20);
    levelReward_[4] = levelReward(10,30);

}

function buyCore(uint256 _pID,uint256 _eth)
    private
{
    
    
   uint256 _com = _eth.mul(1)/100;
    if(_com>0){
        bose.transfer(_com);
    }
    
    
    uint256 _baoxian = _eth.mul(1)/100;
    if(_baoxian>0){
        
        bx.transfer(_baoxian);
        bxTotalCoin = bxTotalCoin.add(_baoxian);
    }
    
    gBet_ = gBet_.add(_eth);
    gBetcc_= gBetcc_ + 1; 
  
    plyr_[_pID].totalBet = _eth.add(plyr_[_pID].totalBet);
    plyr_[_pID].lastBet  = _eth;
    plyrReward_[_pID].level = getLevel(plyr_[_pID].totalBet);
    plyr_[_pID].lastReleaseTime = now;
  


   
}


function getLevel (uint256 _betEth) 
public
view
returns(uint8 level) 
{
    uint8 _level = 0;
     if(_betEth>=31 * ethWei){
        _level = 4;

    }else if(_betEth>=11 * ethWei){
        _level = 3;

    }else if(_betEth>=6 * ethWei){
        _level = 2;

    }else if(_betEth>=1 * ethWei){
        _level = 1;

    }
    return _level;
}


function getPlayerlaById (uint256 _pID)
public
view
returns(uint256,address,uint256,uint256,uint256,uint256,uint256,uint256)
{
   require(_pID>0 && _pID < nextId_, "Now cannot withDraw!");
    return(
        plyr_[_pID].affId,
        plyr_[_pID].addr,
        plyr_[_pID].totalBet,
        plyrReward_[_pID].level,
        plyrReward_[_pID].withDrawEdGen,
        plyrReward_[_pID].withDrawEdAff,
        gBet_,
        gWithDraw_
        );


}

function somethingmsg () 
public
view
returns(uint256 _withdrawPt,uint8 _withdrawCcMax,uint256 _withdrawRate,uint256 _withrawBetmin,uint256 _minbeteth,uint256 _genReleTime)
{
    return(
        withdrawPt,
        withdrawCcMax,
        withdrawRate,
        withrawBetmin,
        minbeteth_,
        genReleTime_
        );

}

function getbestDongtaiBaseUser (uint256 _rid,uint256 _weizhi) 
public
view
returns(uint256 _pID,uint256 _totalBet,uint256 _baseAff) 
{
     _pID = bestDongtaiBaseUser_[_rid][_weizhi];
    return
    (
        _pID,
        plyr_[_pID].totalBet,
        affBijiao_[_rid][_pID]

    );
}


}