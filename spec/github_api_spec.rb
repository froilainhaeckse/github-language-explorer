# frozen_string_literal: true

require 'github_api'
require 'webmock/rspec'

RSpec.describe GithubApi do
  describe '.get_users' do
    it 'queries the GitHub API and receives a response' do
      stub_request(:get, 'https://api.github.com/orgs/codecentric/members')
        .to_return(status: 200, body: '', headers: {})
      response = GithubApi.get_users('codecentric')
      expect(response.code).to eq(200)
    end
  end

  describe '.get_repos' do
    it 'queries the GitHub API and receives a response' do
      stub_request(:get, 'https://api.github.com/users/testuser/repos')
        .to_return(status: 200, body: '', headers: {})
      response = GithubApi.get_repos('testuser')
      expect(response.code).to eq(200)
    end
  end

  describe '.get_languages' do
    it 'queries the GitHub API and receives a response' do
      stub_request(:get, 'https://api.github.com/repos/testuser/repo1/languages')
        .to_return(status: 200, body: '', headers: {})
      response = GithubApi.get_languages('testuser', 'repo1')
      expect(response.code).to eq(200)
    end
  end
end
