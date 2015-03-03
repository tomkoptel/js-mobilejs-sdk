var tests = Object.keys(window.__karma__.files).filter(function (file) {
    return (/(spec|test)\.js$/i).test(file);
});

require.config({
  // Karma serves files under /base, which is the basePath from your config file
  baseUrl: '../',
  path: {
    'jquery': 'bower_components/jquery/dist/jquery.min.js'
  },
  shim: {
    'jQuery': {'exports': 'jquery'}
  },
  // dynamically load all test files
  deps: tests,

  // we have to kickoff jasmine, as it is asynchronous
  callback: window.__karma__.start
});
