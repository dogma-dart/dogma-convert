set -e

# Install dependencies
pub install

# Lint the code
pub global activate linter
pub global run linter .
