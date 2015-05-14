var path, userHome;

path = require('path');

userHome = require('user-home');

module.exports = {
  cacheDirectory: path.join(userHome, '.resin', 'cache'),
  cacheTime: 1 * 1000 * 60 * 60 * 24 * 7
};
