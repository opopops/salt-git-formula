{%- from "git/map.jinja" import git with context %}

include:
  - git.install
  - git.config

{%- for user, repos in git.get('clone', {}).items() %}
  {%- for repo, params in repos.items() %}
    {%- set repo_name = params.get('name', repo) %}

git_clone_{{user}}_{{repo}}:
  git.cloned:
    - name: {{repo_name}}
    - user: {{user}}
    {%- for k, v in params.items() %}
      {%- if k not in ['name', 'user'] %}
    - {{k}}: {{v}}
      {%- endif %}
    {%- endfor %}

  {%- endfor %}
{%- endfor %}
