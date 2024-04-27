# GitHub Language Explorer
This tool is for querying GitHub to explore repositories and discover the programming languages they use.

## Features
- Query Employees: Retrieve a list of employees from GitHub.
- Explore Repositories: View repositories belonging to codecentric employees.
- Discover Programming Languages: Identify the programming languages used in each repository.

## SETUP
#### Clone the repository:

```git clone git@github.com:froilainhaeckse/github-language-explorer.git```

#### Install dependencies:
```bundle install```

#### Set up environment variables:

- Create a `.env` file in the root directory of the project. You can copy `sample.env` and rename it to `.env`.

- Add the following line to the .env file, replacing your_access_token_here with your actual GitHub access token:
```GITHUB_ACCESS_TOKEN=your_access_token_here```

- Note: Make sure to keep your access token private and do not commit it to version control. Add .env to your .gitignore file if it's not already there.

- You can obtain a GitHub access token by following the instructions here: [Creating a personal access token for the command line](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).


## Run the tool:
### See a list of users with their corresponding languages:
```ruby lib/github_language_explorer_script.rb```

### See the users that know a specific language:
```ruby lib/github_language_explorer_script.rb [language]```

for example: ```ruby lib/github_language_explorer_script.rb Scala```

## WIP
This project was done as part of an interview process.

### To Do

- [ ] Improve error handling for API requests.
- [ ] Implement pagination for fetching large datasets.
- [ ] Add unit tests to ensure code reliability.
- [ ] Optimize performance by parallelizing HTTP requests.
- [ ] Enhance user interface for better readability.
- [ ] Fix Metrics/BlockLength: Block has too many lines Rubocop Errors

