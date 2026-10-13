#!/usr/bin/env bash

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh
. ${BUILDPACK_HOME}/lib/canonical_version.sh

VERSIONS=$(fetch_erlang_versions)

testExactErlangVersionAvailable() {
  assertEquals 0 $(exact_erlang_version_available "22.0.3" "$VERSIONS")
}

testExactErlangVersionUnavailable() {
  assertEquals 1 $(exact_erlang_version_available "22.0.1" "$VERSIONS")
}

testExactErlangVersionMajorOnly() {
  assertEquals 1 $(exact_erlang_version_available "21" "$VERSIONS")
}

testExactErlangVersionMajorMinorOnly() {
  assertEquals 0 $(exact_erlang_version_available "21.0" "$VERSIONS")
}

testHeroku24ErlangBuildsUrl() {
  assertEquals "https://builds.hex.pm/builds/otp/ubuntu-24.04" "$(STACK=heroku-24; erlang_builds_url)"
}

testHeroku24ExactErlangVersionAvailable() {
  assertEquals 0 $(STACK=heroku-24; exact_erlang_version_available "27.3.4.2" "$(fetch_erlang_versions)")
}

testHeroku26ErlangBuildsUrl() {
  assertEquals "https://builds.hex.pm/builds/otp/ubuntu-26.04" "$(STACK=heroku-26; erlang_builds_url)"
}

testHeroku26ExactErlangVersionAvailable() {
  assertEquals 0 $(STACK=heroku-26; exact_erlang_version_available "27.3.4.2" "$(fetch_erlang_versions)")
}
