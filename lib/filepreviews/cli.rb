require 'optparse'

module Filepreviews
  # @author Jonah Ruiz <jonah@pixelhipsters.com>
  # A Simple class for the executable version of the gem
  class CLI
    BANNER = <<MSG
Usage: filepreviews [OPTION] [URL]
Description:
Filepreviews.io - Thumbnails and metadata for almost any kind of file

Options:
MSG
    # Passes arguments from ARGV and sets metadata flag
    # @param args [Array<String>] The command-line arguments
    def initialize(args)
      @args, @metadata = args, false
    end

    # Configures the arguments for the command
    # @param opts [OptionParser]
    def options(opts)
      opts.version = Filepreviews::VERSION
      opts.banner  = BANNER
      opts.set_program_name 'Filepreviews.io'

      opts.on('-m', '--metadata', 'load metadata response') do
        @metadata = true
      end

      opts.on_tail('-v', '--version', 'display the version of Filepreviews') do
        puts opts.version
        exit
      end

      opts.on_tail('-h', '--help', 'print this help') do
        puts opts.help
        exit
      end
    end

    # Parses options sent from command-line
    def parse
      opts = OptionParser.new(&method(:options))
      opts.parse!(@args)
      return opts.help if @args.last.nil?

      file_preview = Filepreviews.generate(@args.last)
      @metadata ? file_preview.metadata(js: true) : file_preview
    end
  end
end
