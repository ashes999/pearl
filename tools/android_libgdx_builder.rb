class AndroidLibgdxBuilder < Builder
  TARGET = 'android-libgdx'
  OUTPUT_FILE = 'src/main_game.rb'

  def initialize(args)
    @source_folder = args[:source_folder]
    @output_folder = args[:output_folder]
    @content_folder = args[:content_folder]
    @template_folder = args[:template_folder]
    @mode = args[:mode]
  end

  def build(code)
    # Start writing out files. This is always a "clean" build.
    FileUtils.rm_rf @output_folder

    # Copy the whole Android template_folder
    FileUtils.cp_r("#{@template_folder}", "#{@output_folder}")

    # Write main code file.
    File.open("#{@output_folder}/#{OUTPUT_FILE}", 'w') { |f|
      f.write(code)
    }

    # Build the debug APK
    pwd = Dir.pwd
    Dir.chdir "#{@output_folder}"
    puts "Building APK. Please be patient ..."
    `rake debug >debug.txt`
    Dir.chdir pwd

    puts "APKs generated in #{@output_folder}/bin. Log file is debug.txt"
  end
end