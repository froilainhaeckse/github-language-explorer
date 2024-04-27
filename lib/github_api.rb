require 'dotenv/load'
require 'httparty'

class GithubApi
    include HTTParty
    base_uri 'https://api.github.com'
    headers 'Authorization' => "token #{ENV['GITHUB_ACCESS_TOKEN']}"
  
    def self.get_users(org)
      get("/orgs/#{org}/members")
    end
  
    def self.get_repos(username)
      get("/users/#{username}/repos")
    end

    def self.get_languages(username, repo)
      get("/repos/#{username}/#{repo}/languages")
    end
  end