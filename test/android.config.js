var tests = Object.keys(window.__karma__.files).filter(function (file) {
    return (/(spec|test)\.js$/i).test(file);
});

require.config({
  // Karma serves files under /base, which is the basePath from your config file
  baseUrl: '../',
  paths: {
        'test': 'empty:'
  },
  shim: {
    'test': {'exports': 'test'}
  },
  // dynamically load all test files
  deps: ['test/spec/dashboard_wrapper_test.js'],

  // we have to kickoff jasmine, as it is asynchronous
  callback: window.__karma__.start
});
