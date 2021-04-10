const Harity = artifacts.require('Harity');

contract('Harity', async (accounts) => {
	let contract;

	before(async () => {
		contract = await Harity.deployed();
	});

	describe('When deployed', async () => {
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
});
