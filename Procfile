caddy: caddy run
backend: rdbg --open --nonstop -- bin/rails server -p 3000
frontend: rm -rf public/ && bun run dev
jobs: bin/rake solid_queue:start
rbs: fswatch -0 app lib | xargs -0 -n1 bundle exec rbs-inline --output --opt-out
