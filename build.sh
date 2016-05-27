#!/bin/sh
set -ex

# Get version
dart --version

# Get dependencies
pub install

# Verify that the libraries are error and warning-free.
dartanalyzer ${DARTANALYZER_FLAGS} $(ls -rt lib/*.dart)

# Clone coverage till repo is fixed
git clone -b migration https://github.com/dart-lang/coverage.git ../coverage

# Run the tests
pub global activate --source path ../coverage
OBSERVATORY_PORT=8000
COVERAGE_OUTPUT=coverage.json

dart --checked --observe=${OBSERVATORY_PORT} test/all.dart & \
pub global run coverage:collect_coverage \
    --port=${OBSERVATORY_PORT} \
    --out ${COVERAGE_OUTPUT} \
    --wait-paused \
    --resume-isolates & \
wait

pub global run coverage:format_coverage \
    --package-root=packages \
    --report-on lib \
    --in ${COVERAGE_OUTPUT} \
    --out lcov.info \
    --lcov
