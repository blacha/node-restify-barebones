
module.exports = (grunt) ->


    appPath = ['src/**/*.js']
    testPath = ['test/*.js']
    allPath = appPath.concat testPath

    # Project configuration.
    grunt.initConfig
        pkg: grunt.file.readJSON('package.json'),
        jshint:
            options:
                jshintrc: '.jshintrc'
            src: allPath

        'regex-check':
            files: testPath
            options:
                pattern: /(describe|it)\.only/g

        mochaTest:
            test:
                options:
                    reporter: 'spec'
                    timeout: 1000
                src: testPath

        apidoc:
            myapp:
                src: 'src/',
                dest: 'build/docs/'

        clean:
            build:
                'build'

        # Monitor file changes and restart server
        nodemon:
            dev:
                script: 'src/server.js',
                options:
                    watchedExtensions: ['js']

    grunt.loadNpmTasks 'grunt-contrib-jshint'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-mocha-test'
    grunt.loadNpmTasks 'grunt-regex-check'
    grunt.loadNpmTasks 'grunt-nodemon'
    grunt.loadNpmTasks 'grunt-apidoc'

    # Default task(s).
    grunt.registerTask 'default', ['clean', 'regex-check', 'jshint', 'mochaTest', 'apidoc']
    grunt.registerTask 'test', ['regex-check', 'jshint', 'mochaTest']

    grunt.registerTask 'start', ['nodemon']
