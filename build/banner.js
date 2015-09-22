var spec = require('../package.json');
var version = process.env.VERSION || spec.version;

module.exports =
  spec.name + ' v' + spec.version + '\n' +
  '(c) ' + new Date().getFullYear() + ' ' + spec.author + '\n' +
  'Released under the ' + spec.license +  ' License.';
