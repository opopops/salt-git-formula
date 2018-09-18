{%- from "git/map.jinja" import git with context %}

include:
  - git.install
  - git.config

{%- if 'clone' in git %}
  {%- for user, repos in git.clone.get('users', {}).items() %}
    {%- for repo, params in repos.items() %}
      {%- set repo_name = params.name|default(repo) %}
      {%- set config    = git.clone.get('config', {}) %}
      {%- do config.update(params.get('config', {})) %}
git_clone_{{user}}_{{repo}}:
  file.directory:
    - name: {{params.target.name}}
    - user: {{user}}
    {%- if params.target.get('group', False) %}
    - group: {{params.target.group}}
    {%- endif %}
    {%- if params.target.get('mode', False) %}
    - mode: {{params.target.mode}}
    {%- endif %}
  git.latest:
    - name: {{repo_name}}
    - target: {{params.target.name}}
    - user: {{user}}
    {%- for k, v in config.items() %}
    - {{k}}: {{v}}
    {%- endfor %}

    {%- endfor %}
  {%- endfor %}
{%- endif %}
