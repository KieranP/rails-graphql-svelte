caddy: caddy run
backend: rdbg --open --nonstop -- bin/rails server -p 3000
frontend: rm -rf public/ && bun run dev
jobs: bin/rake solid_queue:start
