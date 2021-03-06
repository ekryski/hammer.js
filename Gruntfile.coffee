module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    # meta options
    meta:
      banner: '/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - ' +
      '<%= grunt.template.today("yyyy-mm-dd") %>\n ' + '<%= pkg.homepage ? "* " + pkg.homepage + "\\n *\\n " : "" %>' +
      '* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %> <<%= pkg.author.email %>>;\n' +
      ' * Licensed under the <%= pkg.license %> license */\n\n'

    # concat src files
    concat:
      options:
        banner: '<%= meta.banner %>'
        separator: '\n\n'
      dist:
        src: [
          'src/intro.js'
          'src/core.js'
          'src/setup.js'
          'src/instance.js'
          'src/event.js'
          'src/utils.js'
          'src/gesture.js'
          'src/gestures.js'
          'src/outro.js']
        dest: 'dist/<%= pkg.name %>-<%= pkg.version %>.js'

    # copy src to latest version
    copy:
      latest:
        src: ['dist/<%= pkg.name %>-<%= pkg.version %>.js']
        dest: 'dist/<%= pkg.name %>-latest.js'
      latestmin:
        src: ['dist/<%= pkg.name %>-<%= pkg.version %>.min.js']
        dest: 'dist/<%= pkg.name %>-latest.min.js'

    # check for optimisations and errors
    jshint:
      options:
        browser: true
      files:
        src: ['dist/<%= pkg.name %>-<%= pkg.version %>.js']

    # minify the sourcecode
    uglify:
      options:
        banner: '<%= meta.banner %>'
      build:
        files:
          'dist/<%= pkg.name %>-<%= pkg.version %>.min.js': ['dist/<%= pkg.name %>-<%= pkg.version %>.js']
          'dist/<%= pkg.name %>-latest.min.js': ['dist/<%= pkg.name %>-<%= pkg.version %>.min.js']

    # watch for changes
    watch:
      scripts:
        files: 'src/*.js'
        tasks: ['concat','copy:latest']
        options:
          interrupt: true

    # simple node server
    connect:
      server:
        options:
          hostname: "0.0.0.0"


  # Load tasks
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-connect'


  # Default task(s).
  grunt.registerTask 'build', ['concat','jshint','uglify','copy']
  grunt.registerTask 'default', ['connect','watch']
