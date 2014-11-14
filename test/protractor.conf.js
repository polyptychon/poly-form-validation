exports.config = {
  seleniumAddress: 'http://localhost:4444/wd/hub',
  jasmineNodeOpts: {defaultTimeoutInterval: 300000},
  specs: ['e2e/**/playAllGames.coffee'],
  baseUrl: 'http://localhost:63342/ionian-game/builds/development/',
  capabilities: {
    browserName: 'chrome',
    version: '',
    platform: 'ANY'
  }
}
