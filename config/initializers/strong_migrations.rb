# frozen_string_literal: true

# Mark existing migrations as safe
# rubocop:disable Style/NumericLiterals
StrongMigrations.start_after = 20240324074937
# rubocop:enable Style/NumericLiterals

# Set timeouts for migrations
StrongMigrations.lock_timeout = 10.seconds
StrongMigrations.statement_timeout = 1.hour

# Analyze tables after indexes are added
# Outdated statistics can sometimes hurt performance
StrongMigrations.auto_analyze = true
