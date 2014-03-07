var assert = require('assert');
var nodes = require('../lib/nodes');
var Context = require('../lib/context').Context;

describe('Context', function () {
	beforeEach(function () {
		this.parent = new Context(new nodes.Rule("body", []))
		this.context = new Context(new nodes.Rule("a", []), this.parent)
	});

	it('returns selectors', function () {
		assert.deepEqual(this.context.selectors(), ["body", "a"])
	});

	it('compiles selector from parent contexts', function () {
		assert.equal(this.context.selector(), "body a")
	});
});