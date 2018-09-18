{%- from "git/map.jinja" import git with context %}

git_pkg:
  pkg.installed:
    - name: {{git.pkg}}
