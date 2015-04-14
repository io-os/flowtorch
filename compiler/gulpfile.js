var gulp = require('gulp'),
    path = require('path');
var typescript = require('gulp-tsc');

// add node_modules to path so we don't need global modules, prefer the modules by adding them first
var nodeModulesPathPrefix = path.resolve("./node_modules/.bin/") + path.delimiter;
if (process.env.path !== undefined) {
  process.env.path = nodeModulesPathPrefix + process.env.path;
} else if (process.env.PATH !== undefined) {
  process.env.PATH = nodeModulesPathPrefix + process.env.PATH;
}
 
gulp.task('compile', function(){
  gulp.src(['src/**/*.ts'])
    .pipe(typescript())
    .pipe(gulp.dest('./dest/'))
});