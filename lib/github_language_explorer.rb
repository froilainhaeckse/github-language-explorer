# frozen_string_literal: true

require 'httparty'
require 'pry'
require_relative 'github_api'

# Class responsible for retrieving and extracting language data from the GitHub API.
class GithubLanguageExplorer
  def self.extract_usernames(organization)
    response = GithubApi.get_users(organization)
    JSON.parse(response.body).map { |user| user['login'] }
  end

  def self.extract_repos(user)
    response = GithubApi.get_repos(user)
    JSON.parse(response.body).map { |repo| repo['name'] }
  end

  def self.retrieve_languages_for_user(user, repos)
    repos.flat_map do |repo|
      response = GithubApi.get_languages(user, repo)
      JSON.parse(response.body).keys
    end.uniq
  end

  def self.print_all_languages_for_users(user_languages)
    puts 'This is a list of users with the languages they are knowledgeable of:'
    user_languages.each do |username, languages|
      puts "Username: #{username}, Languages: #{languages.join(', ')}" unless languages.empty?
    end
  end

  def self.print_user_languages(user_languages, defined_language)
    if defined_language.nil?
      print_all_languages_for_users(user_languages)
    elsif user_languages.empty?
      puts "No users found with language #{defined_language}."
    else
      puts "The following users know language #{defined_language}:"
      user_languages.each_key do |username|
        puts "Username: #{username}" if user_languages[username].include?(defined_language)
      end
    end
  end
end
