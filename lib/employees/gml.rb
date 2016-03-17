require_relative 'man.rb'
Dir[ File.dirname(__FILE__) + "/gml/*.rb"].each {|file| require file }