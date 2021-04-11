const Harity = artifacts.require('Harity');

contract('Harity', async (accounts) => {
	const owner = accounts[0];

	let contract;
	before(async () => {
		contract = await Harity.deployed();
	});

	describe('when deployed', async () => {
		it('should deploy the contract', async () => {
			const address = contract.address;

			assert.notEqual(address, 0x0);
			assert.notEqual(address, '');
			assert.notEqual(address, null);
			assert.notEqual(address, undefined);
		});

		it('has a name', async () => {
			const name = await contract.name();
			assert.equal(name, 'harity');
		});

		it('has a symbol', async () => {
			const symbol = await contract.symbol();
			assert.equal(symbol, 'HRTY');
		});
	});

	/*
	describe('when mint', async () => {
		it('should create a new token', async () => {
			const result = await contract.mint();

			const totalSupply = await contract.totalSupply();
			const event = result.logs[0].args;

			assert.equal(totalSupply, 1);
			assert.equal(event.tokenId.toNumber(), 1);
			assert.equal(event.from, '0x0000000000000000000000000000000000000000');
			assert.equal(event.to, owner);
		});
	});
	*/
});
