require_relative 'man.rb'
Dir[ File.dirname(__FILE__) + "/sos/*.rb"].each {|file| require file }
