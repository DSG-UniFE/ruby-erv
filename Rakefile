if RUBY_PLATFORM =~ /java/

  require 'lib/erv/version'
  require 'bundler/gem_helper'

  require 'nokogiri'
  require 'open-uri'

  # setup absolute path for jars directory
  JAR_DIR = File.expand_path(File.join(File.dirname(__FILE__), 'jars'))

  directory JAR_DIR

  desc 'Get latest snapshot of Apache Commons Math 3.3'
  task :get_latest_commons_math_snapshot => [ JAR_DIR ] do
    # base URL of the apache commons math 3 snapshot repository
    BASE_URL = 'http://repository.apache.org/content/groups/snapshots/org/apache/commons/commons-math3/3.3-SNAPSHOT/'

    # retrieve timestamp and build number of latest snapshot
    puts 'Retrieving metadata information on latest Apache Commons Math 3.3 snapshot.'
    doc = Nokogiri::HTML(open(BASE_URL + 'maven-metadata.xml'))
    timestamp = doc.xpath('//timestamp/text()')
    buildnumber = doc.xpath('//buildnumber/text()')

    # get archive name of latest snapshot
    filename = "commons-math3-3.3-#{timestamp}-#{buildnumber}.jar"

    # get destination file name
    jar_path = File.join(JAR_DIR, filename)

    # don't download if file already exists
    if File.exists?(jar_path)
      puts 'Archive already present in jars directory.'
    else
      puts 'Retrieving latest Apache Commons Math 3.3 snapshot.'
      file_url = BASE_URL + filename
      File.write(jar_path, open(file_url).read)
    end

    # clean JAR_DIR of every file except filename
    puts 'Removing obsolete archives from jars directory.'
    FileUtils.rm(Dir.glob("#{JAR_DIR}/*").reject!{|file| file == jar_path })
  end

  desc "Build erv-#{ERV::VERSION}-java.gem into the pkg directory."
  task :build => [ :get_latest_commons_math_snapshot ] do
    Bundler::GemHelper.instance = Bundler::GemHelper.new
    Bundler::GemHelper.instance.build_gem
  end

else # RUBY_PLATFORM !~ /java/

  require 'bundler/gem_tasks'

end


require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = Dir.glob('test/**/*_test.rb').sort
  t.verbose = true
end
