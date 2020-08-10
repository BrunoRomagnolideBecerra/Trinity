require 'bundler'
require 'watir'
require 'json'
require 'rspec'
require 'yaml'
require 'fileutils'
require 'colorize'
require 'rubygems'
require 'securerandom'
require 'logger'
require 'httpi'
require 'pry'
require 'nori'
require 'net/ssh'
require 'csv'
require 'nokogiri'
require 'os'
require 'win32/registry' if OS.windows?
require 'savon'
require 'win32ole' if OS.windows?
require 'webdrivers'
require 'ipaddr'
require 'socket'
require 'appium_lib'
require_relative '../framework_support/world_order'
require_relative '../framework_support/helpers/settings_helper'

ENV['ENV'] ||= 'demo'

# Created new for each scenario
World(WorldOrder)
WorldOrder.clean_screen_shot_directory

USERS = SettingsHelper.user_configurations
# if running in quiet_mode, raise log levels
if SettingsHelper.environment['quiet_mode']
  HTTPI.log = false
  Watir.logger.level = :error
end