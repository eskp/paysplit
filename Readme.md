Get started:

1. Make sure these are installed: Ganache, Truffle, Metamask Chrome plugin

2. From the Terminal run to start Ganache blockchain

    ganache-cli -i 5777 -p 8545 -u 0

3. From Metamask's login screen select "Import using account seed phrase". Copy Mnemonic from the above Terminal command into Metamask's Wallet Seed text field and create a password. You should see a balance of 100 eth in Metamask.

4. To install project's dependencies, from the root of this repository run

    yarn install

5. Deploy the Solidity contract to Ganace blockchain

    truffle migrate --reset --all

6. Start the development server

    yarn run dev


Keep track and settle crypto expenses between friends.

- Create a group of friends' Eth addresses, give it a name
- Add your friends to the group
- Continuously enter expenses, contract will keep track of who owes what
- Activity - see events and logs

A contract that collects receipts with the total amount from payments of 2 or more participants, works out the balances, splits value owed per participant and sends out the balance owed to each participant.

Use case: 4 friends go on a week end trip 2 of them pay for 3 dinners, 1 pays for accommodation, 1 pays for the car, 3 pay for 3 supermarket shops. After they all input their amounts to the smart contract (in eth) and it works out who owes who.

Instead of paying it off or balancing between all straight away, present further options to:
- Invest the balance to somewhere
- Convert to something
- Keep the balance for the next group gathering
- Create own Token
- Create little bets/games eg. double or nothing
- Chat
- Push notifications
- Set group photo
- Picture of receipt
