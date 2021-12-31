# Starter Template: Rails + GraphQL + Svelte

This repo contains a starter template for a Rails+GraphQL API and Svelte frontend.

## Features

### Backend

The backend is powered by Ruby on Rails, with a GraphQL API.

It includes a secure JWT & 2FA authentication system, and authorisation using Pundit.

It is pre-wired with ActionCable for Websockets, and Sidekiq for background processing.

It includes Rspec and Capybara for feature tests, and Rubocop/Brakeman for code analysis.

It contains a basic config for Github Actions.

### Frontend

The frontend is powered by Svelte, and compiled using Vite.

Routing is handled by Routify, and API requests made using Apollo.

Styling is provided by Bootstrap, and websockets via ActionCableJS.

Dependencies are managed via Yarn.

## Usage

* Clone Git Repo
* Adjust `config/database.yml`
* `bundle install`
* `yarn install`
* `bin/rspec`
* `foreman start`

## File Structure

### Backend

The backend is powered by a standard Ruby on Rails app. The only exception is that Sprockets is not included for asset management and there are no Rails views templates. All HTML/CSS/JS is handled by Vite.

### Frontend

When Vite runs, it clears the contents of `/public`, then takes the contents of `/app/frontend` and compiles them together into `/public`. The result is a frontend application that is embedded into a Ruby on Rails app for ease of development, whilst still being able to be extracted and deployed to a CDN for production. Frontend configs are managed via `vite.config.js` and `routify.config.js`
