<h1>Lottery Smart Contract</h1>

<p>This is a simple lottery smart contract built using Solidity. It allows participants to enter the lottery by purchasing tickets, and the owner can pick a winner at the end of the lottery.</p>

<h2>Table of Contents</h2>
<ul>
    <li><a href="#features">Features</a></li>
    <li><a href="#contract-structure">Contract Structure</a></li>
    <li><a href="#functions">Functions</a></li>
    <li><a href="#events">Events</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#license">License</a></li>
</ul>

<h2 id="features">Features</h2>
<ul>
    <li>Participants can enter the lottery by paying a ticket price of 1 ether.</li>
    <li>The contract owner can pick a random winner from the participants.</li>
    <li>The winner receives the entire balance of the contract.</li>
    <li>All participants' addresses are stored in an array.</li>
</ul>

<h2 id="contract-structure">Contract Structure</h2>
<pre><code>contract Lottery {
    address public owner;
    address[] public participants;
    uint256 public lotteryId;
    uint256 public immutable ticketPrice;
    
    event LotteryEntered(address indexed participants);
    event SelectedWinner(address indexed winner, uint256 amount);
    
    constructor();
    modifier onlyOwner;
    function enter() public payable;
    function pickWinner() public onlyOwner;
    function random() private view returns(uint256);
    function getParticipants() public view returns(address[] memory);
    function getContractBalance() public view returns(uint256);
}</code></pre>

<h2 id="functions">Functions</h2>
<h3>1. `constructor()`</h3>
<p>Initializes the contract, setting the owner to the address that deploys the contract and setting the ticket price to 1 ether.</p>

<h3>2. `enter()`</h3>
<p>Allows participants to enter the lottery by sending the exact ticket price (1 ether).</p>

<h3>3. `pickWinner()`</h3>
<p>Called by the owner to select a random winner from the participants and transfer the contract's balance to the winner.</p>

<h3>4. `random()`</h3>
<p>Generates a pseudo-random number based on the previous block's hash, the current timestamp, and the participants' addresses.</p>

<h3>5. `getParticipants()`</h3>
<p>Returns the list of participants currently entered in the lottery.</p>

<h3>6. `getContractBalance()`</h3>
<p>Returns the current balance of the contract.</p>

<h2 id="events">Events</h2>
<ul>
    <li><code>LotteryEntered(address indexed participants)</code> - Emitted when a participant enters the lottery.</li>
    <li><code>SelectedWinner(address indexed winner, uint256 amount)</code> - Emitted when a winner is selected.</li>
</ul>

<h2 id="usage">Usage</h2>
<ol>
    <li>Deploy the contract on an Ethereum network.</li>
    <li>Participants can call the <code>enter()</code> function to buy a lottery ticket.</li>
    <li>The owner can call the <code>pickWinner()</code> function to select a winner.</li>
</ol>
