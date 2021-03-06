require 'sinatra'
require 'json'
require 'git'
require 'fileutils'

DBLATEX_CONF_FILE = 'dblatex.conf'

post '/payload' do
  push = JSON.parse(request.body.read)
  #puts "I got some JSON: #{push.inspect}"

  owner = push['repository']['owner']['name'] #edusantana
  repo_name = push['repository']['name'] #playground-asciidoc
  full_name = push['repository']['full_name'] # edusantana/playground-asciidoc
  git_url = push['repository']['git_url']
  working_dir = full_name

  puts "debug owner:#{owner} repo_name:#{repo_name}"

  FileUtils::rm_f full_name
  FileUtils::mkdir_p owner

  begin
    g = Git.open(working_dir, :log => Logger.new(STDOUT))
    g.reset_hard
    g.pull
  rescue ArgumentError
    g = Git.clone(git_url, repo_name, :path => owner)
  end

  Dir.chdir(full_name) do
    system %Q(abnt_asciidoc rascunho)
    system %Q(abnt_asciidoc trabalho-academico > trabalho-academico.tex)
    system %Q(pdflatex trabalho-academico.tex)
    system %Q(pdflatex trabalho-academico.tex)

    #system %Q(asciidoctor -d book -b docbook5 livro.asc)

    # If file DBLATEX_CONF_FILE exists it will be used as configuration file
    # http://dblatex.sourceforge.net/doc/manual/sec-specs.html
    #dblatex_conf = File.exists?(DBLATEX_CONF_FILE) ? "-S #{DBLATEX_CONF_FILE}" : ""
    #system %Q(dblatex #{dblatex_conf} livro.xml)
  end

end
