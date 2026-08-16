#!/usr/bin/env ruby

require 'optparse'

TASKS_FILE = 'tasks.txt'
options = {}

parser = OptionParser.new do |opts|
  opts.banner = "Usage: cli.rb [options]"

  opts.on("-a", "--add TASK", "Add a new task") do |task|
    options[:add] = task
  end

  opts.on("-l", "--list", "List all tasks") do
    options[:list] = true
  end

  opts.on("-r", "--remove INDEX", Integer, "Remove a task by index") do |index|
    options[:remove] = index
  end

  opts.on("-h", "--help", "Show help") do
    puts opts
    exit
  end
end

parser.parse!

if options[:add]
  File.open(TASKS_FILE, 'a') { |file| file.puts options[:add] }
  puts "Task '#{options[:add]}' added."

elsif options[:list]
  puts "Tasks:"
  if File.exist?(TASKS_FILE)
    File.readlines(TASKS_FILE, chomp: true).each do |task|
      puts task
    end
  end

elsif options[:remove]
  if File.exist?(TASKS_FILE)
    tasks = File.readlines(TASKS_FILE, chomp: true)
    index = options[:remove] - 1

    if index.between?(0, tasks.length - 1)
      removed = tasks.delete_at(index)
      File.write(TASKS_FILE, tasks.join("\n") + (tasks.empty? ? "" : "\n"))
      puts "Task '#{removed}' removed."
    end
  end

else
  puts parser
end
