pragma solidity ^0.4.24;

contract ScamPonzi
{
    uint public timer = 0;
    address public lastPlayer;
    bool public contestCompleted = false;
    uint public limit = 1 minutes;

    modifier contestRunning
    {
        require(!contestCompleted);
        _;
    }

    function invest()
        payable
        contestRunning
        public
    {
        require(msg.value >= 0.1 ether);

        uint thirtyminsdown = ((msg.value - 0.1 ether) / 0.1 ether);
        uint dr = thirtyminsdown * 30 seconds;
        uint minLimit = limit - 10;
        if (dr >= minLimit) {
            dr = minLimit;
        }
        limit -= dr;

        timer = now;
        lastPlayer = msg.sender;
    }

    modifier afterDeadline
    {
        require((now - timer) >= limit);
        _;
    }

    modifier onlyLastPlayer
    {
        require(msg.sender == lastPlayer);
        _;
    }

    function getBalance()
        public
        view
        returns (uint)
    {
        return address(this).balance;
    }

    function withdraw()
        public
        afterDeadline
        onlyLastPlayer
    {
        contestCompleted = true;
        lastPlayer.transfer(getBalance());
    }
}
