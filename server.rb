require 'sinatra'
require 'json'
require 'git'

post '/payload' do
  push = JSON.parse(request.body.read)
  #puts "I got some JSON: #{push.inspect}"

  owner = push['repository']['owner']['login']
  repo_name = push['repository']['name']
  full_name = push['repository']['full_name'] # edusantana/playground-asciidoc

  git_url = push['repository']['git_url']
  full_name = push['repository']['full_name']
  working_dir = full_name

  begin
    g = Git.open(working_dir, :log => Logger.new(STDOUT))
    g.reset_hard
    g.pull
  rescue ArgumentError
    g = Git.clone(git_url, repo_name, :path => owner)
  end

  Dir.chdir("#{working_dir}/livro") do
    system %Q(asciidoctor livro.asc)
    system %Q(asciidoctor -d book -b docbook5 livro.asc)
    system %Q(dblatex -P latex.encoding=utf8 livro.xml)
  end

end
