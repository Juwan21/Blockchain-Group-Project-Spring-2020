# CryptoCraps Blockchain Team Project Spring 2020:

**Team Members:**

***Ben Carter, Juwan Smith, Kayla Walker, Troy White***

**4/27/20**

**CSC 4980**


## How to setup the environment:

* Make sure you are in the `Final-Proj` folder .

* Check your current truffle version with `truffle version` in your **Node.js** command prompt that matches the text below:

 > `Truffle v5.1.21 (core: 5.1.21)`

 > `Solidity v0.4.24 or later. (solc-js)`

* If your Truffle and Solidity versions do not match the specifications above find and install the appropiate versions from the web.

* Also make sure you are running the *Ganache* application. 

* Have your Meta Mask account ready to be used.

 


## Steps to run and test CryptoCraps DApp:

1. Download GitHub zip file

2. Open your node.js/console/command prompt

3. Create a Final_Proj directory. Enter the directory.

4. Enter the command: `truffle unbox pet-shop-tutorial`

5. Copy CryptoCraps.sol into contracts folder

6. Copy index.html into src folder

7. Copy initContract.js into src/js folder

8. Copy a Javascript file called 2_deploy_contracts.js into the Migrations folder

9. Set solc compile in truffle-config.js file to solidity version `v0.4.24` 

10. Within your Final_Proj directory run the command: `truffle migrate --reset`

11. Run the command: `npm run dev` to open the DApp in the server

12. Enjoy the game. Don't lose all your money, we're not responsible for your addiction.
