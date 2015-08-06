grunfs = require('fs');
grunt = require('grunt');
grunt.loadNpmTasks('grunt-coffee-react');
grunt.loadNpmTasks('grunt-concat-sourcemap');
grunt.loadNpmTasks('grunt-contrib-sass');
grunt.loadNpmTasks('grunt-contrib-uglify');
grunt.loadNpmTasks('grunt-contrib-watch');
grunt.loadNpmTasks('grunt-concurrent');
grunt.loadNpmTasks('grunt-browserify');
grunt.loadNpmTasks('grunt-exorcise');

// in order to maintain short compilation times in the final output, the
// source files are grouped into 2 bundles:
//   - bundle (for application behavior code)
//   - bundle_lib (for library files)

// coffeescript targets
coffeescript_targets = {
  "js/.compilation_intermediates/stores.coffeebundle.js":
    "js/stores/*.cjsx",
  "js/.compilation_intermediates/actions.coffeebundle.js":
    "js/actions/*.cjsx",
  "js/.compilation_intermediates/components.coffeebundle.js":
    "js/components/*.cjsx"
}

js_bundle_targets = [
  "js/.compilation_intermediates/init.js",
  "js/.compilation_intermediates/*.coffeebundle.js"
]

module.exports = function(grunt) {

  grunt.initConfig({
    browserify: {
      lib: {
        files:{
          'js/.compilation_intermediates/bundle_lib.js':
            "js/lib.js"}},

      sources: {
        options: {browserifyOptions:{
          "transform": "coffee-reactify",
          "extension": "cjsx",
          "debug": true
        }},
        files:{
          'js/.compilation_intermediates/bundle_sources.js':
            "js/init.cjsx"}}
    },

    // excorcising (extracting the source map from) the bundle
    exorcise:{
      bundle_sources:{
        files: {
          "js/.compilation_intermediates/bundle_sources.js.map":
            ["js/.compilation_intermediates/bundle_sources.js"]
        }
      }
    },

    // uglifying (mangling and minifying) scripts
    uglify: {
      bundle_lib: {
        files: {'www/js/bundle_lib.min.js':
          'js/.compilation_intermediates/bundle_lib.js'},
      },

      bundle_sources: {
        options: {
          sourceMap: true,
          sourceMapIncludeSources: true,
          sourceMapIn: "js/.compilation_intermediates/bundle_sources.js.map"
        },
        files: {'www/js/bundle_sources.min.js':
          'js/.compilation_intermediates/bundle_sources.js'},
      }
    },

    sass: {
      options: {
        style: 'compressed',
        update: true
      },
      index: {
        files:{
          'www/css/index.css': 'css/index.scss'
        }
      }
    },

    concurrent: {
      precompile: [
        "precompile_lib",
        "precompile_sources",
        "precompile_styles"
      ],
      watch_working_sources: {
        options: {
          logConcurrentOutput: true,
        },
        tasks: [
          "watch:precompile_sources",
          "watch:precompile_styles",
        ]
      }
    },

    // watch changes in init.cjsx and modules
    watch: {
      precompile_sources: {
        files: ["js/init.cjsx", "js/*/*.cjsx", "!js/lib"],
        tasks: ["precompile_sources"]
      },

      precompile_styles: {
        files: ["css/*.scss"],
        tasks: ["precompile_styles"]
      },
    }

  });


  grunt.registerTask(
    'precompile_sources',
    ['browserify:sources',
     'exorcise:bundle_sources',
     'uglify:bundle_sources']);

  grunt.registerTask(
    'precompile_lib',
    ['browserify:lib', 'uglify:bundle_lib']);

  grunt.registerTask('precompile_styles', ['sass:index']);

  grunt.registerTask('dev',
    ['concurrent:precompile', 'concurrent:watch_working_sources']);

  grunt.registerTask('default', ['concurrent:precompile']);

};
