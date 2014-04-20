#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'trollop'
require_relative "serialize"

opts = Trollop::options do
  opt :action, "Action to perform on project (unpack|pack)", :short => "a", :type => String
  opt :project, "RPG Maker Project directory", :short => "d", :type => String
  opt :force, "Update target even when source is older than target", :short => "f"
  opt :project_type, "Project type (vx|ace|xp)", :short => "t", :type => String
  opt :verbose, "Print verbose information while processing", :short => "V"
end

directions = {
  "unpack" => :all_bin_to_text,
  "pack" => :all_text_to_bin
}
projecttypes = {
  "vx" => :vx,
  "ace" => :ace,
  "xp" => :xp
}
$VERBOSE=opts[:verbose]

RGSS.serialize(projecttypes[opts[:project_type]],
               directions[opts[:action]],
               opts[:project],
               { :force => (opts[:force] ? true : false),
                 :line_width => -1,
                 :table_width => -1
               }
               )

