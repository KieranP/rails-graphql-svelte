backend: bundle exec rdbg -O -n -c -- bin/rails server -p 3001
frontend: rm -rf public/ && bun run dev --port 3000
caddy: caddy run
jobs: bin/rake solid_queue:start
