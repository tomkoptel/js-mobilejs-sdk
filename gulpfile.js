var gulp = require('gulp'),
    gp_concat = require('gulp-concat');

gulp.task('default', function () {
    return gulp
        .src([
            'bower_components/deferred-js/js/deferred.min.js',
            'src/common.js',
            'src/rest-report.js',
            'src/viz-report.js',
            'src/viz-dashboard.js'
        ])
        .pipe(gp_concat('/jaspermobile.js'))
        .pipe(gulp.dest('build'));
});