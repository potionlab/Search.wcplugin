#!/System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/bin/ruby

require_relative '../../bundle/bundler/setup'
require 'json'
require 'Shellwords'
require 'pathname'

require_relative "../lib/test_script_constants"
require_relative "../lib/test_data_constants"

command = "#{TEST_DATA_SEARCH_COMMAND} \"#{SEARCH_TERM}\" #{Shellwords.escape(TEST_DATA_DIRECTORY)}"
match_lines = `#{command}`

matches = []
match_lines.each_line do |line_match|
  match_hash = Hash.new

  result = /(.*):(.*):(.*)/.match(line_match)
  if result
    file_path = result.captures[0]
    line_number = result.captures[1]
    matched_text = result.captures[2]
  else
    # Grep doesn't add the full metadata in front of subsequent matches in the same file
    # So construct the match from the previous match
    previous_match = matches.last
    file_path = previous_match[FILE_PATH_KEY]
    line_number = previous_match[LINE_NUMBER_KEY]
    matched_text = line_match.chomp
  end

  display_file_path = Pathname.new(file_path).relative_path_from(Pathname.new(TEST_DATA_DIRECTORY)).to_s
  match_hash[FILE_PATH_KEY] = File.expand_path(file_path)
  match_hash[DISPLAY_FILE_PATH_KEY] = display_file_path
  match_hash[LINE_NUMBER_KEY] = line_number
  match_hash[MATCHED_TEXT_KEY] = matched_text
  matches << match_hash
end

puts matches.to_json