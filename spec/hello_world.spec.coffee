chai = require 'chai'
fs = require 'fs'
cheerio = require('cheerio')
path = require('path')
jQuery = require('jquery')

source = path.resolve(__dirname, '../../fixtures/dumy_dashboard.html')

JasperMobile = require(path.resolve(__dirname, '../chore'))
#console.log JasperMobile.Logger

dom = fs.readFileSync(source, "utf8") + ""

$ = cheerio.load(dom)
$.html()

chai.should()
