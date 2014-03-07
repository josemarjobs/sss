var fs = require('fs');
var util = require('util');
var spawn = require('child_process').spawn;
var lib = "lib";
var test = "test";

fs.watchFile('lib/grammar.jison', function() {
	compile_parser();
})
;fs.watchFile('lib/tokens.jisonlex', function() {
	compile_parser();
})
;fs.watchFile('lib/nodes.js', function() {
	compile_parser();
});

fs.watch(test, function() {
	run_tests();
});

function compile_parser(){
  var jison  = spawn('jison', [
  	'lib/grammar.jison', 
  	'lib/tokens.jisonlex',
  	'-o',
  	'lib/parser.js'
  ]);
  jison.stdout.on('data', function (data) {
		util.log('jison:stdout: ' + data);
	});

	jison.stderr.on('data', function (data) {
		util.log('jison:stderr: ' + data);
	});
	jison.on('close', function (code) {
		run_tests();
	});
}


function run_tests(){
	var mocha = spawn('mocha', ['--reporter', 'spec']);
	mocha.stdout.on('data', function (data) {
		console.log(data.toString());
	});

	mocha.stderr.on('data', function (data) {
		console.log(data.toString());
	});
}
util.log("Watching file changes.");