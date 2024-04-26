require 'httparty'

class GithubLanguageExplorer
    def self.query_github_api
        HTTParty.get('https://api.github.com/orgs/codecentric/members')
    end
end