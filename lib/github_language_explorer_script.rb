# frozen_string_literal: true

require_relative 'github_language_explorer'

def run_github_language_explorer(language = nil)
  organization = 'codecentric'

  usernames = GithubLanguageExplorer.extract_usernames(organization)

  user_languages = {}
  usernames.each do |username|
    repos = GithubLanguageExplorer.extract_repos(username)
    languages = GithubLanguageExplorer.retrieve_languages_for_user(username, repos)
    user_languages[username] = languages if language.nil? || languages.include?(language)
  end
  GithubLanguageExplorer.print_user_languages(user_languages, language)
end

if ARGV.empty?
  run_github_language_explorer
else
  run_github_language_explorer(ARGV[0])
end
