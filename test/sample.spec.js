(function() {
    'use strict';

    describe('Sample', function() {

        process.env.NODE_ENV = 'test';
        var expect = require('chai').expect;
        var PORT = null;
        var request = require('request');
        var server = require('../src/server');

        var log = server.getLogger();

        before(function(done) {
            server.startServer(function(server) {
                PORT = server.address().port;
                log.warn('SERVER %d', PORT);
                done();
            });
        });

        it('should pass a test', function() {
            expect(1).to.equal(1);
        });

        it('should have server running', function(done) {
            request('http://127.0.0.1:' + PORT + '/api/key', function(error, response, body) {
                var bJson = JSON.parse(body);
                expect(bJson.response).to.equal('get-key');
                done();
            });
        });

        it('should respond to GET', function(done) {
            request('http://127.0.0.1:' + PORT + '/api/key', function(error, response, body) {
                var bJson = JSON.parse(body);
                expect(bJson.response).to.equal('get-key');
                done();
            });
        });

        it('should respod to POST', function(done) {
            request.post('http://127.0.0.1:' + PORT + '/api/key', function(error, response, body) {
                var bJson = JSON.parse(body);
                expect(bJson.response).to.equal('post-key');
                done();
            });
        });
    });

})();