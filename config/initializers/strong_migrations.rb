# frozen_string_literal: true

# Mark existing migrations as safe
StrongMigrations.start_after = 2024_03_24_07_49_37

# Set timeouts for migrations
StrongMigrations.lock_timeout = 10.seconds
StrongMigrations.statement_timeout = 1.hour

# Analyze tables after indexes are added
# Outdated statistics can sometimes hurt performance
StrongMigrations.auto_analyze = true
