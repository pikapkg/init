workflow "Build, Test, and Publish" {
  on = "push"
  resolves = ["Publish"]
}

action "Build" {
  uses = "actions/npm@master"
  args = "install && build:pika"
}

action "Test" {
  needs = "Build"
  uses = "actions/npm@master"
  args = "lint"
}

# Filter for master branch
  action "Master" {
  needs = "Test"
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Publish" {
  needs = "Master"
  uses = "actions/npm@master"
  args = "publish --access public"
  secrets = ["NPM_TOKEN"]
}
