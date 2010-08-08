# Add lib to loadpath
$: << File.join(File.dirname(__FILE__), "/../lib" )
$: << File.join(File.dirname(__FILE__), "/../spec/temp" )

require 'spec'
require "csvrecord"