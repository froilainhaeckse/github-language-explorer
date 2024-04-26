require 'github_language_explorer'

RSpec.configure do |config|
    describe GithubLanguageExplorer do
        describe '#query_github_api' do
        it 'queries the GitHub API and receives a response' do
          response = GithubLanguageExplorer.query_github_api
          expect(response).to be_success
        end
      end
    end
end