# frozen_string_literal: true

require 'github_language_explorer'
require 'webmock/rspec'

RSpec.configure do |_config|
  describe GithubLanguageExplorer do
    describe '#extract_usernames' do
      it 'extracts member usernames from the GitHub API response' do
        response = double('response', body: '[{"login": "user1"}, {"login": "user2"}]')
        allow(GithubApi).to receive(:get_users).and_return(response)

        usernames = GithubLanguageExplorer.extract_usernames('codecentric')
        expect(usernames).to contain_exactly('user1', 'user2')
      end
    end

    describe '#extract_repos' do
      it 'extracts repository names from the GitHub API response' do
        response = double('response', body: '[{"name": "repo1"}, {"name": "repo2"}]')
        allow(GithubApi).to receive(:get_repos).and_return(response)

        repos = GithubLanguageExplorer.extract_repos('testuser')
        expect(repos).to contain_exactly('repo1', 'repo2')
      end
    end

    describe '#retrieve_languages_for_user' do
      it 'retrieves languages for the repositories of a user' do
        user = 'testuser'
        repos = %w[repo1 repo2]
        languages_response1 = double('response1', body: { 'Ruby' => 100, 'JavaScript' => 200 }.to_json)
        languages_response2 = double('response2', body: { 'Ruby' => 300, 'Scala' => 200 }.to_json)
        allow(GithubApi).to receive(:get_languages).with(user, 'repo1').and_return(languages_response1)
        allow(GithubApi).to receive(:get_languages).with(user, 'repo2').and_return(languages_response2)

        languages = GithubLanguageExplorer.retrieve_languages_for_user(user, repos)
        expect(languages).to contain_exactly('Ruby', 'JavaScript', 'Scala')
      end
    end

    describe '#print_user_languages' do
      it 'prints a list of users with their known languages' do
        user_languages = {
          'user1' => %w[Ruby JavaScript],
          'user2' => ['Python']
        }
        language = nil

        expect { GithubLanguageExplorer.print_user_languages(user_languages, language) }
          .to output("This is a list of users with the languages they are knowledgeable of:\nUsername: user1, " \
            "Languages: Ruby, JavaScript\nUsername: user2, Languages: Python\n").to_stdout
      end

      it 'prints a list of users who know a specific language' do
        user_languages = {
          'user1' => %w[Ruby JavaScript],
          'user2' => ['Python']
        }
        language = 'Ruby'

        expect { GithubLanguageExplorer.print_user_languages(user_languages, language) }
          .to output("The following users know language Ruby:\nUsername: user1\n").to_stdout
      end

      it 'prints a message when no users are found with a specific language' do
        user_languages = {}
        language = 'Java'

        expect { GithubLanguageExplorer.print_user_languages(user_languages, language) }
          .to output("No users found with language Java.\n").to_stdout
      end
    end
  end
end
